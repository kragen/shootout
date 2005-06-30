// The Great Computer Language Shootout
// http://shootout.alioth.debian.org/
//
// contributed by David Hedbor
// modified by Isaac Gouy

function Toggle(start_state) {
  this.bool = start_state;
  function value () {
    return this.bool;
  }
  
  function activate () {
    this.bool = !this.bool;
    return this;
  }
}

function NthToggle (start_state, max_counter) {
  this.base = Toggle;
  this.base(start_state);
  this.count_max = max_counter;
  this.count = 0;

  function activate () {
    if (++this.count >= this.count_max) {
      this.bool = !this.bool;
      this.count = 0;
    }
    return this;
  }
}

NthToggle.prototype = new Toggle;

var n = arguments[0];
var i;

var toggle = new Toggle(true);
for (i = 0; i < 5; i++) {
  toggle.activate();
  print(toggle.value() ? "true" : "false");
}
for (i = 0; i < n; i++) {
  toggle = new Toggle(true);
}

print("");

var ntoggle = new NthToggle(1, 3);
for (i = 0; i < 8; i++) {
  ntoggle.activate();
  print((ntoggle.value()) ? "true" : "false");
}
for (i = 0; i < n; i++) {
   ntoggle = new NthToggle(1, 3);
}