//!/usr/bin/env node
// stackexchange.js
// Author: Andy Bettisworth
// Created At: 2015 0728 210044
// Modified At: 2015 0728 210044
// Description: userscript to fix grammatical errors on Stack Exchange

// https://github.com/AstroCB/Stack-Exchange-Editor-Toolkit

//// Rebuild

var main = function() {
  // Define app namespace
  var StackExchange = {};
  StackExchange.selections = {};

  StackExchange.URL = window.location.href;

  StackExchange.question_id = StackExchange.URL.match(/\/(\d+)\//g);
  if (StackExchange.question_id) {
    StackExchange.question_id = StackExchange.question_id[0].split("/").join("");
  }

  StackExchange.button_html = '<li \
    class="wmd-button" \
    id="wmd-button-grammar-bot-' + StackExchange.question_id + '" \
    title="Grammar Bot" \
    style="left: 460px;"> \
      <img src="//i.imgur.com/79qYzkQ.png" \
           alt="Grammar Bot Edit" \
           width="18px;" \
           height="18px;"> \
    </li>';

  StackExchange.edits = {
    i: {
      expr: /(^|\s|\()i(\s|,|\.|!|\?|;|\/|\)|'|$)/gm,
      replacement: "$1I$2",
      reason: "in English, the pronoun 'I' is capitalized"
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
    }
  };

  StackExchange.fix_it = function() {
  };

  StackExchange.get_selections = function() {
    StackExchange.selections.redo_button = $("#wmd-redo-button-" + StackExchange.question_id);
    StackExchange.selections.title = $("#title");
    StackExchange.selections.body = $("#wmd-input-" + StackExchange.question_id);
    StackExchange.selections.submit = $("#submit-button");
  };

  StackExchange.insert_button = function() {
    StackExchange.selections.redo_button.after(StackExchange.button_html);
    StackExchange.selections.button_fix = $("#wmd-button-grammar-bot-" + StackExchange.question_id);
    StackExchange.selections.button_fix.click(function(e) {
      e.preventDefault();
      // > apply edits
    });
  };

  StackExchange.init = function() {
    StackExchange.get_selections();
    StackExchange.insert_button();
  }

  setTimeout(function() {
    if ($(".post-editor")[0]) {
      StackExchange.init();
    }
  }, 1000);
};

// Inject script into DOM which will give access to jQuery "$"
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
