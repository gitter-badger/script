#!/usr/bin/python
# django_object_csv.py
# Author: Andy Bettisworth
# Description: Generate CSV from Django model objects and their attributes

import csv
import logging

from django.core import serializers
from django.http import HttpResponse

from corpsec.models import LegalHoldRequest
from infotech.models import WITSite, SiteHours, FITAnalyst
from wm.models import Site, BusinessUnit

logger = logging.getLogger('gz')

class ObjectCSV(object):

    def __init__(self, *args, **kwargs):
        try:
            self.model        = kwargs['model']
            self.model_meta   = kwargs['model']._meta
            self.model_fields = kwargs['model']._meta.fields
        except: raise StandardError("Argument 'model' is required")

        try:
            self.id_list = kwargs['id_list']
        except:
            self.id_list = None

        try:
            self.attr_list = kwargs['attr_list'].split(',')
            self.replace_id_attr_with_pk()
        except:
            self.attr_list = [field.name for field in self.model_fields]

    def write(self):
        self.response = HttpResponse(content_type='text/csv')
        self.init_csv_file()

        self.write_csv_header()
        self.write_object_rows()

        return self.response

    def replace_id_attr_with_pk(self):
        for n,i in enumerate(self.attr_list):
            if i=='id':
                self.attr_list[n] = 'pk'

    def init_csv_file(self):
        self.response['Content-Disposition'] = 'attachment; filename=%s.csv' % unicode(self.model_meta).replace('.', '_')
        self.writer = csv.writer(self.response)

    def write_csv_header(self):
        csv_header = []

        if 'pk' in self.attr_list:
            csv_header.append(unicode('ID'))

        for field in self.model_fields:
            if field.name in self.attr_list:
                csv_header.append(field.verbose_name)

        for obj in self.related_list:
            try:
                title = eval(str(obj) + "._meta.verbose_name")
                csv_header.append(title)
            except:
                csv_header.append('ERROR: ' + str(obj) + ' not found')

        self.writer.writerow(csv_header)

    def write_object_rows(self):
        if self.id_list:
            self.object_list = self.model.objects.filter(id__in=self.id_list)
        else:
            self.object_list = self.model.objects.all()

        for record in self.object_list:
            row = []
            for attr in self.attr_list:
                if attr == "pk":
                    row.append(record.id)
                else:
                    try:
                        row.append(getattr(record, attr))
                    except:
                        row.append('invalid attribute')

            for obj in self.related_list:
                try:
                    related = eval(str(obj) + '.objects.filter(' + \
                      str(record.__class__.__name__).lower() + '=' + str(record.id) + ')')

                    try:
                        content = "\n".join(str(i.csv_formatted()) for i in related)
                    except:
                        content = "\n".join(str(i) for i in related)

                    row.append(content)
                except:
                    row.append('ERROR: No csv formatting available')

            self.writer.writerow(row)

class WITSiteObjectCSV(ObjectCSV):

    def __init__(self, *args, **kwargs):
        self.model        = WITSite
        self.model_meta   = WITSite._meta
        self.model_fields = WITSite._meta.fields

        try:
            self.id_list = kwargs['id_list']
        except:
            self.id_list = []

        try:
            self.attr_list = kwargs['attr_list'].split(',')
            self.replace_id_attr_with_pk()
        except:
            self.attr_list = [field.name for field in self.model_fields]

        try:
            self.related_list = kwargs['related_list'].split(',')
        except:
            self.related_list = []

class LegalHoldObjectCSV(ObjectCSV):

    def __init__(self, *args, **kwargs):
        self.model        = LegalHoldRequest
        self.model_meta   = LegalHoldRequest._meta
        self.model_fields = LegalHoldRequest._meta.fields

        try:
            self.id_list = kwargs['id_list']
        except:
            self.id_list = None

        try:
            self.attr_list = kwargs['attr_list'].split(',')
            self.replace_id_attr_with_pk()
        except:
            self.attr_list = [field.name for field in self.model_fields]
