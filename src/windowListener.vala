public class WindowListener : Object {
    public signal void itemAdded();

    public void invokeItemAdded() {
            itemAdded();
        }
}
