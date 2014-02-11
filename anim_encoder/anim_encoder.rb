#!/usr/bin/ruby -w
# anim_encoder.rb
# Description: Generate animations from ordered png images

class AnimEncoder

  import scipy.ndimage.measurements as me
  import json
  import scipy.misc as misc
  import re
  import sys
  import os
  import cv2
  from numpy import *
  from time import time

  # How long to wait before the animation restarts
  END_FRAME_PAUSE = 4000
  # How many pixels can be wasted in combining neighbouring changed regions.
  SIMPLIFICATION_TOLERANCE = 512
  MAX_PACKED_HEIGHT = 10000

  def slice_size(a, b)
    (a.stop - a.start) * (b.stop - b.start)
  end

  def combine_slices(a, b, c, d)
    (slice(min(a.start, c.start), max(a.stop, c.stop)),
     slice(min(b.start, d.start), max(b.stop, d.stop)))
  end

  def slices_intersect(a, b, c, d)
    return false if (a.start >= c.stop)
    return false if (c.start >= a.stop)
    return false if (b.start >= d.stop)
    return false if (d.start >= b.stop)
    true
  end

  # Combine a large set of rectangles into a smaller set of rectangles,
  # minimising the number of additional pixels included in the smaller set of
  # rectangles
  def simplify(boxes, tol = 0)
    out = []
    for a,b in boxes:
      sz1 = slice_size(a, b)
      did_combine = false
      for i in xrange(len(out)):
        c,d = out[i]
        cu, cv = combine_slices(a, b, c, d)
        sz2 = slice_size(c, d)
        if slices_intersect(a, b, c, d) ||
          (slice_size(cu, cv) <= sz1 + sz2 + tol)
            out[i] = (cu, cv)
            did_combine = true
            break
          end
      if not did_combine
        out.append((a,b))
      end
    if tol != 0
      simplify(out, 0)
    else
      out
    end
  end

  def slice_tuple_size(s)
    a, b = s
    return (a.stop - a.start) * (b.stop - b.start)
  end

  # Allocates space in the packed image. This is very slow.
  class Allocator2D
    def __init__(self, rows, cols)
      self.bitmap = zeros((rows, cols), dtype=uint8)
      self.available_space = zeros(rows, dtype=uint32)
      self.available_space[:] = cols
      self.num_used_rows = 0
    end

    def allocate(self, w, h)
      bh, bw = shape(self.bitmap)

      for row in xrange(bh - h + 1):
        if self.available_space[row] < w
          continue
        end

        for col in xrange(bw - w + 1):
          if self.bitmap[row, col] == 0
            if not self.bitmap[row:row+h, col:col+w].any()
              self.bitmap[row:row+h, col:col+w] = 1
              self.available_space[row:row+h] -= w
              self.num_used_rows = max(self.num_used_rows, row + h)
              return row, col
            end
          end
      raise RuntimeError()
    end

  def find_matching_rect(bitmap, num_used_rows, packed, src, sx, sy, w, h)
    template = src[sy:sy+h, sx:sx+w]
    bh, bw = shape(bitmap)
    image = packed[0:num_used_rows, 0:bw]

    return None if num_used_rows < h

    result = cv2.matchTemplate(image,template,cv2.TM_CCOEFF_NORMED)

    row,col = unravel_index(result.argmax(),result.shape)
    if ((packed[row:row+h,col:col+w] == src[sy:sy+h,sx:sx+w]).all() &&
        (packed[row:row+1,col:col+w,0] == src[sy:sy+1,sx:sx+w,0]).all())
      row,col
    else
      None
    end
  end

  def generate_animation(anim_name)
    frames = []
    rex = re.compile("screen_([0-9]+).png")
    for f in os.listdir(anim_name):
      m = re.search(rex, f)
      if m
        frames.append((int(m.group(1)), anim_name + "/" + f))
      end
    frames.sort()

    images = [misc.imread(f) for t, f in frames]

    zero = images[0] - images[0]
    pairs = zip([zero] + images[:-1], images)
    diffs = [sign((b - a).max(2)) for a, b in pairs]

    # Find different objects for each frame
    img_areas = [me.find_objects(me.label(d)[0]) for d in diffs]

    # Simplify areas
    img_areas = [simplify(x, SIMPLIFICATION_TOLERANCE) for x in img_areas]

    ih, iw, _ = shape(images[0])

    # Generate a packed image
    allocator = Allocator2D(MAX_PACKED_HEIGHT, iw)
    packed = zeros((MAX_PACKED_HEIGHT, iw, 3), dtype=uint8)

    # Sort the rects to be packed by largest size first, to improve the packing
    rects_by_size = []
    for i in xrange(len(images)):
       src_rects = img_areas[i]

        for j in xrange(len(src_rects)):
          rects_by_size.append((slice_tuple_size(src_rects[j]), i, j))

    rects_by_size.sort(reverse = true)

    allocs = [[None] * len(src_rects) for src_rects in img_areas]

    print anim_name,"packing, num rects:",len(rects_by_size),"num frames:",len(images)

    t0 = time()

    for size,i,j in rects_by_size:
        src = images[i]
        src_rects = img_areas[i]

        a, b = src_rects[j]
        sx, sy = b.start, a.start
        w, h = b.stop - b.start, a.stop - a.start

        # See if the image data already exists in the packed image. This takes
        # a long time, but results in worthwhile space savings (20% in one
        # test)
        existing = find_matching_rect(allocator.bitmap,
                                      allocator.num_used_rows,
                                      packed,
                                      src,
                                      sx,
                                      sy,
                                      w,
                                      h)
        if existing
          dy, dx = existing
          allocs[i][j] = (dy, dx)
        else
          dy, dx = allocator.allocate(w, h)
          allocs[i][j] = (dy, dx)

          packed[dy:dy+h, dx:dx+w] = src[sy:sy+h, sx:sx+w]
        end

    print anim_name,"packing finished, took:",time() - t0

    packed = packed[0:allocator.num_used_rows]

    misc.imsave(anim_name + "_packed_tmp.png", packed)
    # Don't completely fail if we don't have pngcrush
    if os.system("pngcrush -q #{anim_name}_packed_tmp.png #{anim_name}_packed.png") == 0
      os.system("rm #{anim_name}_packed_tmp.png")
    else
      print "pngcrush not found, output will not be larger"
      os.system("mv #{anim_name}_packed_tmp.png #{anim_name}_packed.png")
    end

    # Generate JSON to represent the data
    times = [t for t, f in frames]
    delays = (array(times[1:] + [times[-1] + END_FRAME_PAUSE]) - array(times)).tolist()

    timeline = []
    for i in xrange(len(images)):
      src_rects = img_areas[i]
      dst_rects = allocs[i]

      blitlist = []

      for j in xrange(len(src_rects)):
          a, b = src_rects[j]
          sx, sy = b.start, a.start
          w, h = b.stop - b.start, a.stop - a.start
          dy, dx = dst_rects[j]

          blitlist.append([dx, dy, w, h, sx, sy])

      timeline.append({'delay': delays[i], 'blit': blitlist})

    f = open(anim_name + '_anim.js', 'wb')
    f.write(anim_name + "_timeline = ")
    json.dump(timeline, f)
    f.close()
  end

  if __name__ == '__main__'
    generate_animation(sys.argv[1])
  end
end
