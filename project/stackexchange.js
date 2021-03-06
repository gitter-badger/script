//!/usr/bin/env node
// stackexchange.js
// Author: Andy Bettisworth
// Created At: 2015 0728 210044
// Modified At: 2015 0728 210044
// Description: userscript to fix grammatical errors on Stack Exchange

// https://github.com/AstroCB/Stack-Exchange-Editor-Toolkit

//// Rebuild

//!/usr/bin/env node
// stackexchange.js
// Author: Andy Bettisworth
// Created At: 2015 0728 210044
// Modified At: 2015 0728 210044
// Description: userscript to fix grammatical errors on Stack Exchange

// https://github.com/AstroCB/Stack-Exchange-Editor-Toolkit

//// Rebuild

var main = function() {
  var StackBot = {};
  StackBot.items = [];
  StackBot.selections = {};
  StackBot.completed_edit = false;
  StackBot.edit_count = 0;
  StackBot.URL = window.location.href;
  StackBot.reasons = [];
  StackBot.reason_count = 0;

  StackBot.question_id = StackBot.URL.match(/\/(\d+)\//g);
  if (StackBot.question_id) {
    StackBot.question_id = StackBot.question_id[0].split("/").join("");
  }

  StackBot.button_html = '<li \
    class="wmd-button" \
    id="wmd-button-grammar-bot-' + StackBot.question_id + '" \
    title="Grammar Bot" \
    style="left: 420px;"> \
      <img src="//i.imgur.com/79qYzkQ.png" \
           alt="Grammar Bot" \
           width="18px;" \
           height="18px;"> \
    </li>';

  StackBot.edits = {
    iam: {
        expr: /(^|\s)[Ii]\s*am|[Ii]\s*AM(.|$)/gm,
        replacement: "$1I'm$2",
        reason: "I'm is more concise."
    },
    so: {
        expr: /(^|\s)[Ss]tack\s*overflow|StackOverflow(.|$)/gm,
        replacement: "$1Stack Overflow$2",
        reason: "'Stack Overflow' is the legal name"
    },
    se: {
        expr: /(^|\s)[Ss]tack\s*exchange|StackExchange(.|$)/gm,
        replacement: "$1Stack Exchange$2",
        reason: "'Stack Exchange' is the legal name"
    },
    javascript: {
        expr: /(^|\s)[Jj]ava\s*script(.|$)/gm,
        replacement: "$1JavaScript$2",
        reason: "'JavaScript' is the proper capitalization"
    },
    jsfiddle: {
        expr: /(^|\s)[Jj][Ss]\s+[Ff]iddle(.|$)/gm,
        replacement: "$1JSFiddle$2",
        reason: "'JSFiddle' is the currently accepted capitalization"
    },
    jquery: {
        expr: /(^|\s)[Jj][Qq]uery(.|$)/gm,
        replacement: "$1jQuery$2",
        reason: "'jQuery' is the proper capitalization"
    },
    html: {
        expr: /(^|\s)[Hh]tml(5|\s|$)/gm,
        replacement: "$1HTML$2",
        reason: "HTML stands for HyperText Markup Language"
    },
    css: {
        expr: /(^|\s)[Cc]ss(\s|$)/gm,
        replacement: "$1CSS$2",
        reason: "CSS stands for Cascading Style Sheets"
    },
    json: {
        expr: /(^|\s)[Jj]son(\s|$)/gm,
        replacement: "$1JSON$2",
        reason: "JSON stands for JavaScript Object Notation"
    },
    ajax: {
        expr: /(^|\s)ajax(\s|$)/gm,
        replacement: "$1AJAX$2",
        reason: "AJAX stands for Asynchronous JavaScript and XML"
    },
    angular: {
        expr: /[Aa]ngular[Jj][Ss]/g,
        replacement: "AngularJS",
        reason: "'AngularJS is the proper capitalization"
    },
    sqlite: {
        expr: /(^|\s)[Ss]qlite([0-9]*)(\s|$)/gm,
        replacement: "$1SQLite$2$3",
        reason: "SQLite is the proper capitalization"
    },
    android: {
        expr: /(^|\s)android(\s|$)/gmi,
        replacement: "$1Android$2",
        reason: "Android should be capitalizaed"
    },
    ubuntu: {
        expr: /(ubunto|ubunut|ubunutu|ubunu|ubntu|ubutnu|ubanto[o?]|unbuntu|ubunt|ubutu)(\s|$)/igm,
        replacement: "Ubuntu$2",
        reason: "corrected Ubuntu spelling"
    },
    linux: {
        expr: /(linux)(\s|$)/igm,
        replacement: "Linux$2",
        reason: "Linux should be capitalized"
    },
    wordpress: {
        expr: /[Ww]ordpress/g,
        replacement: "WordPress",
        reason: "'WordPress' is the proper capitalization"
    },
    google: {
      expr:  /(google)(\s|$)/igm,
      replacement: "Google$2",
      reason: "Google is the proper capitalization"
    },
    mysql: {
      expr:  /(mysql)(\s|$)/igm,
      replacement: "MySQL$2",
      reason: "MySQL is the proper capitalization"
    },
    apache: {
      expr:  /(apache)(\s|$)/igm,
      replacement: "Apache$2",
      reason: "Apache is the proper capitalization"
    },
    github: {
      expr:  /\b([gG]ithub|GITHUB)(\s|$)/gm,
      replacement: "GitHub$2",
      reason: "GitHub is the proper capitalization"
    }
  };

  StackBot.rm_duplicates = function(arr) {
    var i, len = arr.length,
      out = [],
      obj = {};

    for (i = 0; i < len; i++) {
      obj[arr[i]] = 0;
    }
    for (i in obj) {
      if (obj.hasOwnProperty(i)) {
        out.push(i);
      }
    }
    return out;
  };

  StackBot.output = function(data) {
    StackBot.selections.title.val(data[0].title);
    StackBot.selections.body.val(data[0].body);

    if (StackBot.selections.summary_box.val()) {
      data[0].summary = " " + data[0].summary;
    }
    StackBot.selections.summary_box.val(StackBot.selections.summary_box.val() + data[0].summary);

    StackBot.current_pos = document.body.scrollTop;
    if ($("#wmd-input")) {
      $("#wmd-input").focus();
      $("#edit-comment").focus();
      $("#wmd-input").focus();
    } else {
      $(".wmd-input")[0].focus();
      $(".edit-comment")[0].focus();
      $(".wmd-input")[0].focus();
    }
    window.scrollTo(0, StackBot.current_pos);
  };

  StackBot.fix_it = function(input, expression, replacement, reasoning) {
    var match = input.search(expression);
    if (match !== -1) {
      StackBot.edit_count++;
      var phrase;

      if (replacement === "") {
        input = input.replace(expression, function(data, match1) {
          phrase = match1;
          return "";
        });
        reasoning = reasoning.replace("$1", phrase);
      } else {
        input = input.replace(expression, replacement);
      }

      return {
        reason: reasoning,
        fixed: input
      };
    } else {
      return null;
    }
  };

  StackBot.editing = function(data) {
    StackBot.selections.body.animate({
        backgroundColor: '#c8ffa7'
    }, 10);
    StackBot.selections.body.animate({
        backgroundColor: '#fff'
    }, 1000);

    for (var j in StackBot.edits) {
      // Fix body content
      var fix = StackBot.fix_it(data[0].body, StackBot.edits[j].expr,
        StackBot.edits[j].replacement, StackBot.edits[j].reason);
      if (fix) {
        console.log('body fix: ' + fix.reason)
        StackBot.reasons[StackBot.reason_count] = fix.reason;
        data[0].body = fix.fixed;
        StackBot.reason_count++;
        StackBot.edits[j].fixed = true;
      }

      // Fix title content
      fix = StackBot.fix_it(data[0].title, StackBot.edits[j].expr,
        StackBot.edits[j].replacement, StackBot.edits[j].reason);
      if (fix) {
        console.log('title fix: ' + fix.reason)
        data[0].title = fix.fixed;
        if (!StackBot.edits[j].fixed) {
          StackBot.reasons[StackBot.reason_count] = fix.reason;
          StackBot.reason_count++;
          StackBot.edits[j].fixed = true;
        }
      }
    }

    // Remove duplicate reasons
    StackBot.reasons = StackBot.rm_duplicates(StackBot.reasons);

    // Formatting applied to summary
    for (var z = 0; z < StackBot.reasons.length; z++) {
      if (data[0].summary.length < 200) {
        if (z === 0) {
          data[0].summary += StackBot.reasons[z][0].toUpperCase() +
              StackBot.reasons[z].substring(1);
        } else {
          data[0].summary += StackBot.reasons[z];
        }

        if (z !== StackBot.reasons.length - 1) {
          data[0].summary += "; ";
        } else {
          data[0].summary += ".";
        }
      }
    }

    return data;
  };

  StackBot.pop_items = function() {
    StackBot.items[0] = {
      title: StackBot.selections.title.val(),
      body: StackBot.selections.body.val(),
      summary: ''
    };
  };

  StackBot.insert_button = function() {
    StackBot.selections.redo_button.after(StackBot.button_html);
    StackBot.selections.button_fix = $("#wmd-button-grammar-bot-" + StackBot.question_id);
    StackBot.selections.button_fix.click(function(e) {
      e.preventDefault();

      if (!StackBot.completed_edit) {
        data = StackBot.editing(StackBot.items);
        StackBot.output(data);
        StackBot.completed_edit = true;
      }
    });
  };

  StackBot.get_selections = function() {
    StackBot.selections.redo_button = $("#wmd-redo-button-" + StackBot.question_id);
    StackBot.selections.title = $("#title");
    StackBot.selections.body = $("#wmd-input-" + StackBot.question_id);
    StackBot.selections.tag_field = $($(".tag-editor")[0]);
    StackBot.selections.summary_box = $("#edit-comment");
    StackBot.selections.submit = $("#submit-button");
  };

  StackBot.init = function() {
    StackBot.get_selections();
    StackBot.insert_button();
    StackBot.pop_items();
  }

  setTimeout(function() {
    if ($(".post-editor")[0]) {
      StackBot.init();
    }
  }, 1000);
};

// Inject script into DOM (grants access to jQuery "$")
var script = document.createElement('script');
script.type = "text/javascript";
script.textContent = '(' + main.toString() + ')();';
document.body.appendChild(script);

//// Add custom rules

// anArbitraryName: {
//     expr: /aRegularExpression/,
//     replacement: "What to replace it with (may include captured text like $1)",
//     reason: "an unpunctuated reason starting with a lowercase letter that will be formatted automatically and inserted into the edit summary"
// },

//// Default rules

// Capitalizes the first letter of new lines
// Removes common greetings
// Removes "thanks" and similar phrases
// Removes "Edit:" and similar modifiers
// Replaces the now-banned mysite.domain with example.domain
// Fixes improperly used contractions
// Corrects all-caps titles

//// Install userscript for Chrome

// 1. Browse in Chrome to chrome://extensions
// 2. Drag the myscript.user.js file into that page.
