/* The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 *
 * contributed by Kenneth Jonsson
 */
#include <alloca.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

/* The work area are for local variables and return addresses. */
#define STACK_WORK_SZ 32*1024

/*
 * Assume 4kB pages, which is true for both i386 and x86_64, some
 * OS:es requires stack sizes aligned to a page boundary.
 * Linux does not, OS X does.
 */
#define PAGE_SIZE (1 << 12)

#define bottom_up_tree(item, depth)                                     \
    init_node(alloca(sizeof(struct node) * num_elem(depth)),            \
              item,                                                     \
              num_elem(depth))

struct node {
    int item;
    struct node *left;
    struct node *right;
};

struct item_worker_data {
    int iterations;
    int depth;
    int check;
};

struct args {
    int min_depth;
    int max_depth;
};


static int
num_elem(int height)
{
    if (height < 0)
        return 0;
    return (1 << height) + num_elem(height - 1);
}

/*
 * Some pthread implementations requires that the stack size is a
 * multiple of the size of a page
 */
static int
stack_sz(int depth)
{
    int sz = (num_elem(depth) * sizeof(struct node) + STACK_WORK_SZ);
    return (sz + PAGE_SIZE - 1) & ~(PAGE_SIZE - 1);
}

static int
node_check(const struct node *n)
{
    if (n->left)
        return node_check(n->left) + n->item - node_check(n->right);
    return n->item;
}

static struct node *
init_node(struct node *node, int item, int n)
{
    int subtree_n; /* Number of nodes in left/right subtree to this
                    * node */

    if (n == 0)
        return NULL;

    node->item = item;
    subtree_n = n / 2;
    /*
     * left subtree is stored in the front half of the stack space and
     * the right subtree is stored in the back half of the stack
     * space
     */
    node->left = init_node(node + 1, 2 * item - 1, subtree_n);
    node->right = init_node(node + 1 + subtree_n, 2 * item, subtree_n);
    return node;
}

/*
 * Do one iteration, must be in a non-static function to ensure that
 * the stack frame is released between each invocation, i.e. this
 * function must not be inlined.
 */
int
do_one_iteration(int i, int depth)
{
    struct node *a, *b;

    a = bottom_up_tree(i, depth);
    b = bottom_up_tree(-i, depth);
    return node_check(a) + node_check(b);
}

/*
 * Calculate the checksum at a specific depth. This is the equivalent
 * of the body to the the outer for-loop of most other
 * solutions. Enough space to store two trees with a depth of
 * 'wd->depth'
 */
void *
item_worker(void *arg)
{
    struct item_worker_data *wd = arg;
    int i;

    for (i = 1; i <= wd->iterations; ++i)
        wd->check += do_one_iteration(i, wd->depth);
    return wd;
}

/*
 * The calculations is started in reverse order compared to most other
 * solutions. The reason is that all data must be on the stack and the
 * result from shallowest tree must be printed first.
 */
void
do_trees(int depth, int min_depth, int max_depth)
{
    pthread_t thread;
    pthread_attr_t attr;
    struct item_worker_data wd;

    if (depth < min_depth)
        return;

    pthread_attr_init(&attr);
    pthread_attr_setstacksize(&attr, stack_sz(depth + 1));

    wd.iterations = 1 << (max_depth - depth + min_depth);
    wd.check = 0;
    wd.depth = depth;
    pthread_create(&thread, &attr, item_worker, &wd);

    do_trees(depth-2, min_depth, max_depth);

    pthread_join(thread, NULL);
    pthread_attr_destroy(&attr);

    printf("%d\t trees of depth %d\t check: %d\n",
           2 * wd.iterations,
           depth,
           wd.check);
}

void
stretchdepth_tree(int depth)
{
    struct node *stretch_tree = bottom_up_tree(0, depth);

    printf("stretch tree of depth %i\t check: %i\n",
           depth,
           node_check(stretch_tree));
}

/*
 * Main function with enough stack space to fit the tree used to
 * 'stretch' memory. Same space is reused to the long lived tree.
 */
void *
main_thread(void *args_)
{
    struct node *long_lived_tree;
    struct args *args = args_;

    stretchdepth_tree(args->max_depth + 1);
    long_lived_tree = bottom_up_tree(0, args->max_depth);
    /*
     * Calculates all subtrees for every second depth ranging from
     * min_depth up to, but not including max_depth
     */
    do_trees(args->max_depth & ~1,
             args->min_depth,
             args->max_depth);
    printf("long lived tree of depth %i\t check: %i\n",
           args->max_depth,
           node_check(long_lived_tree));

    return NULL;
}

int
main(int argc, char *argv[])
{
    int req_depth = (argc == 2 ? atoi(argv[1]) : 10);
    pthread_t thread;
    pthread_attr_t attr;
    struct args args;

    args.min_depth = 4;
    args.max_depth = (req_depth > args.min_depth + 2
                      ? req_depth
                      : args.min_depth + 2);

    pthread_attr_init(&attr);
    pthread_attr_setstacksize(&attr, stack_sz(args.max_depth + 1));
    pthread_create(&thread, &attr, main_thread, &args);
    pthread_attr_destroy(&attr);
    pthread_join(thread, NULL);

    return 0;
}
