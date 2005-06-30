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
var val = true;
var toggle = new Toggle(val);
for (i=0; i<n; i++) {
  val = toggle.activate().value();
}
print(toggle.value() ? "true" : "false");

val = true;
var ntoggle = new NthToggle(val, 3);
for (i=0; i<n; i++) {
  val = ntoggle.activate().value();
}
print(ntoggle.value() ? "true" : "false");