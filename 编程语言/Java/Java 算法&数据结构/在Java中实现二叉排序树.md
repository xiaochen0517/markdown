# 在Java中实现二叉排序树

## 1.二叉树的概念和特点

### 1.1二叉树

- 特点
  - 每个节点最多有两颗子树
  - 左子树和右子树是有顺序的，次序不能颠倒。
  - 即使某个节点只有一个子树，也要区分左右子树
- 图示

<img src="photo\二叉树示意图.png" style="zoom:80%;" />

### 1.2节点

- 节点的组成
  - 指向它的左子节点
  - 节点中的内容
  - 指向它的右子节点
- 图示

![](photo\二叉树子节点构成.png).

### 1.3二叉排序树

- 二叉排序树的特点
  - 每个根节点中的左子节点的值都小于根节点中的值
  - 每个根节点中的右子节点的值都大于根节点中的值
  - 树中没有重复的值

## 2.实现二叉排序树

### 2.1实现节点

- `Node.java`

```java
public class Node {

    //节点中的值
    private int value;

    //左子节点
    private Node leftNode;
    //右子节点
    private Node rightNode;

    public Node(){
    }

    public Node(int value){
        this.value = value;
    }

    @Override
    public String toString() {
        return "Node{" +
                "value=" + value +
                '}';
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }

    public Node getLeftNode() {
        return leftNode;
    }

    public void setLeftNode(Node leftNode) {
        this.leftNode = leftNode;
    }

    public Node getRightNode() {
        return rightNode;
    }

    public void setRightNode(Node rightNode) {
        this.rightNode = rightNode;
    }
}
```

### 2.2实现二叉树

- `BinaryTree.java`

```java
public class BinaryTree {

    //根节点
    private Node root;

    public BinaryTree(){
    }

    public BinaryTree(Node root){
        this.root = root;
    }

    public Node getRoot() {
        return root;
    }
}
```

### 2.3添加节点方法

```java
/**
* 添加节点
* @param value 节点值
* @return 是否成功
*/
public boolean add(int value){
	if (this.root == null){
		//如果二叉树根节点为null则将node添加进根节点
		this.root = new Node(value);
		return true;
	}else{
        Node current = root;
        while (true){
            if (value < current.getValue()){
                //传入的value和根节点的值相比较小时，检查根节点的左节点
                if (current.getLeftNode() == null){
                    //如果根节点的左节点为null，则将传入的value加入左节点
                    current.setLeftNode(new Node(value));
                    return true;
                }else{
                    //如果根节点的左节点有值，则将根节点设置为左节点
                    current = current.getLeftNode();
                }
            }else if (value > current.getValue()){
                //传入的node和根节点的值相比较大时，检查根节点的右节点
                if (current.getRightNode() == null){
                    //如果根节点的右节点为null，则将传入的value加入右节点
                    current.setRightNode(new Node(value));
                    return true;
                }else{
                    //如果根节点的右节点有值，则将根节点设置为右节点
                    current = current.getRightNode();
                }
            }else{
                return false;
            }
        }
    }
}
```

### 2.4获取指定节点

```java
    /**
     * 获取指定的节点
     * @param value 需要获取的值
     * @return 返回节点node
     */
    public Node get(int value){
        Node current = root;
        while(true){
            if (value == current.getValue()){
                //如果传入的值和current的值相等，直接返回
                return current;
            }else if (value < current.getValue()){
                //如果传入的值和current的值相比较小，则将current设置为它的左节点
                current = current.getLeftNode();
            }else if (value > current.getValue()){
                //如果传入的值和current的值相比较大，则将current设置为它的右节点
                current = current.getRightNode();
            }

            if (current == null){
                //如果current为空，则表示没有此值
                return null;
            }
        }
    }
```

### 2.5遍历二叉树

```java
    /**
     * 遍历节点
     * @param node 根节点
     */
    public void order(Node node){
        if (node == null) return;
        //遍历左节点
        order(node.getLeftNode());
        //输出节点
        System.out.println(node);
        //遍历右节点
        order(node.getRightNode());
    }
```

### 2.6`toString()`方法遍历

- 改造`order()`方法

```java
    private String restr;
	public void order2(Node node){
        if (node == null) return;
        //遍历左节点
        order2(node.getLeftNode());
        //输出节点
        restr = restr + " " + node.getValue();
        //遍历右节点
        order2(node.getRightNode());
    }
```

- 在`BinaryTree`中重写`toString()`方法

```java
    @Override
    public String toString() {
        restr = "[";
        order2(root);
        return restr+" ]";
    }
```

### 2.7测试

```java
int[] a = {3, 1, 0, 2, 7, 5, 8, 9};

BinaryTree binaryTree = new BinaryTree();
//存入数据
for (int i : a) {
	binaryTree.add(i);
}

//取值
System.out.println(binaryTree.get(5));
//遍历
binaryTree.order(binaryTree.getRoot());
//使用toString方法遍历
System.out.println(binaryTree);
```

- 输出结果

```
Node{value=5}
Node{value=0}
Node{value=1}
Node{value=2}
Node{value=3}
Node{value=5}
Node{value=7}
Node{value=8}
Node{value=9}
[ 0 1 2 3 5 7 8 9 ]
```

