/*
 * The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 *
 * Contributed by Eckehard Berns
 * Based on code by Kevin Carson
 */

#include <stdlib.h>
#include <stdio.h>
#include <pthread.h>

typedef struct node {
   struct node *left, *right;
   long item;
} node;

static node *
new_node(node *left, node *right, long item)
{
   node *ret;

   ret = malloc(sizeof(node));
   ret->left = left;
   ret->right = right;
   ret->item = item;

   return ret;
}

static long
item_check(node *tree)
{
   if (tree->left == NULL)
      return tree->item;
   else
      return tree->item + item_check(tree->left) -
          item_check(tree->right);
}

static node *
bottom_up_tree(long item, int depth)
{
   if (depth > 0)
      return new_node(bottom_up_tree(2 * item - 1, depth - 1),
          bottom_up_tree(2 * item, depth - 1), item);
   else
      return new_node(NULL, NULL, item);
}

static void
delete_tree(node *tree)
{
   if (tree->left != NULL) {
      delete_tree(tree->left);
      delete_tree(tree->right);
   }
   free(tree);
}

struct worker_args {
   long iter, check;
   int depth;
   pthread_t id;
   struct worker_args *next;
};

static void *
check_tree_of_depth(void *_args)
{
   struct worker_args *args = _args;
   long i, iter, check, depth;
   node *tmp;

   iter = args->iter;
   depth = args->depth;

   check = 0;
   for (i = 1; i <= iter; i++) {
      tmp = bottom_up_tree(i, depth);
      check += item_check(tmp);
      delete_tree(tmp);

      tmp = bottom_up_tree(-i, depth);
      check += item_check(tmp);
      delete_tree(tmp);
   }

   args->check = check;
   return NULL;
}

int
main(int ac, char **av)
{
   node *stretch, *longlived;
   struct worker_args *args, *targs, *hargs;
   int n, depth, mindepth, maxdepth, stretchdepth;

   n = ac > 1 ? atoi(av[1]) : 10;
   if (n < 1) {
      fprintf(stderr, "Wrong argument.\n");
      exit(1);
   }

   mindepth = 4;
   maxdepth = mindepth + 2 > n ? mindepth + 2 : n;
   stretchdepth = maxdepth + 1;

   stretch = bottom_up_tree(0, stretchdepth);
   printf("stretch tree of depth %u\t check: %li\n", stretchdepth,
       item_check(stretch));
   delete_tree(stretch);

   longlived = bottom_up_tree(0, maxdepth);

   hargs = NULL;
   targs = NULL;
   for (depth = mindepth; depth <= maxdepth; depth += 2) {

      args = malloc(sizeof(struct worker_args));
      args->iter = 1 << (maxdepth - depth + mindepth);
      args->depth = depth;
      args->next = NULL;
      if (targs == NULL) {
         hargs = args;
         targs = args;
      } else {
         targs->next = args;
         targs = args;
      }
      pthread_create(&args->id, NULL, check_tree_of_depth, args);
   }

   while (hargs != NULL) {
      args = hargs;
      pthread_join(args->id, NULL);
      printf("%ld\t trees of depth %d\t check: %ld\n",
          args->iter * 2, args->depth, args->check);
      hargs = args->next;
      free(args);
   }

   printf("long lived tree of depth %d\t check: %ld\n", maxdepth,
       item_check(longlived));

   /* not in original C version: */
   delete_tree(longlived);

   return 0;
}

