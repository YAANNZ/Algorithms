package com.zyn.myAlgorithms.链表;

public class 删除链表中的节点_237 {
    // 删除链表中的节点
    class Solution {
        public void deleteNode(ListNode node) {
            node.val = node.next.val;
            node.next = node.next.next;
        }
    }
}
