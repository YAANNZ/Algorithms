package com.zyn.myAlgorithms.链表;

public class 删除链表中的节点_237 {
    // 删除链表中的节点
    public class ListNode {
        int val;
        ListNode next;
        ListNode(int x) { val = x; }
    }

    class Solution {
        public void deleteNode(ListNode node) {
            node.val = node.next.val;
            node.next = node.next.next;
        }
    }
}
