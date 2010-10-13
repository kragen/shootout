<p>Notice that sought sequences (GGT GGTA GGTATT GGTATTTTAATT GGTATTTTAATTTATAGT) newer overlap and create new function find_seq() with built-in function count(). Previous program iterated all data in function sort_seq() - char by char.</p>
<p>Improved gen_func() - removed "if" statement and used defaultdict() function</p>
<p><b>BUT</b> skips the sequence generation in the sequence finder step. def find_seq(seq, nucleo): count = seq.count(nucleo) return nucleo, count</p>
