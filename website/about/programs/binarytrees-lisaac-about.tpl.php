<pre><strong>NOT ACCEPTED:</strong> When given an existing tree, like is done in the inner loop, it *explicitly reuses memory* allocated for the tree, and only mutates the item fields of the tree, until it reaches the leaves at which point new nodes are allocated and added to the tree.
</pre>
