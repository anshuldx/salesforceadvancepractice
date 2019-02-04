public with sharing class SimpleController {
    private static SimpleController classInstance;

    static {
        classInstance = new SimpleController();
    }

    private SimpleController() {
        
    }

    public static SimpleController getInstance() {
        return classInstance;
    }
}