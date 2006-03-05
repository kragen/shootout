rem The Computer Language Shootout
rem http://shootout.alioth.debian.org/
rem contributed by Josh Goldfoot
rem based on the C version by Kevin Carson

option explicit

type treeNode
    as treeNode ptr tleft
    as treeNode ptr tright
    as long titem
end type

sub DeleteTree(tree as treeNode ptr)
    if (tree->tleft <> 0) then
        DeleteTree(tree->tleft)
        DeleteTree(tree->tright)
    end if
    deallocate tree
end sub

function ItemCheck(tree as treeNode ptr) as long
    if tree->tleft = 0 then
        return tree->titem
    else
        return tree->titem + ItemCheck(tree->tleft) - ItemCheck(tree->tright)
    end if
end function

function NewTreeNode(ntleft as treeNode Ptr, ntright as treeNode Ptr, item as long) as treeNode ptr
    dim newp as treeNode ptr

    newp = callocate(len(treeNode))
    newp->tleft = ntleft
    newp->tright = ntright
    newp->titem = item
    return newp
end function

function BottomUpTree(item as long, depth as uinteger) as treeNode ptr
    if (depth > 0) then
        dim as treeNode ptr newl, newr
        newl = BottomUpTree(2 * item - 1, depth - 1)
        newr = BottomUpTree(2 * item, depth - 1)
        return NewTreeNode(newl, newr, item)
    else
        return NewTreeNode(0, 0, item)
    end if
end function

sub main()
    dim as uinteger N, depth, minDepth, maxDepth, stretchDepth
    dim as treeNode ptr stretchTree, longLivedTree, tempTree
    dim as long i, iterations, check

    N = val(command$)
    if N < 1 then N = 16

    minDepth = 4

    if minDepth + 2 > N then
        maxDepth = minDepth + 2
    else
        maxDepth = N
    end if

    stretchDepth = maxDepth + 1

    stretchTree = BottomUpTree(0, stretchDepth)
    print "stretch tree of depth "; str(stretchDepth);chr(9);" check: ";
    print str(ItemCheck(stretchTree))
    DeleteTree(stretchTree)

    longLivedTree = BottomUpTree(0, maxDepth)
    for depth = minDepth to maxDepth step 2
        iterations = 2 ^ (maxDepth - depth + minDepth)
        check = 0
        for i = 1 to iterations
            tempTree = BottomUpTree(i, depth)
            check += ItemCheck(tempTree)
            DeleteTree(tempTree)
            tempTree = BottomUpTree(-1 * i, depth)
            check += ItemCheck(tempTree)
            DeleteTree(tempTree)
        next i
        print str(iterations * 2);chr(9);" trees of depth ";str(depth);
        print chr(9);" check: ";str(check)
    next depth

    print "long lived tree of depth ";str(maxDepth);chr(9);
    print " check: "; str(ItemCheck(longLivedTree))
end sub

main()

