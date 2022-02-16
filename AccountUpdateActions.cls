public class AccountUpdateActions {
	@invocableMethod(label='On Account Updation' description='Runs when an account is updated')
	public static void updateAccountsWithTasks (List<Account> accounts) {
        List<Task> tasks;
        // Query active users to list
        List<User> activeUsers = [SELECT Id, Name FROM User WHERE IsActive = true]; 
        // Selecting random user from a list
		User randomUser = activeUsers [Integer.valueof (Math.random() * (activeUsers.size() - 1))];
        // Adding Account Ids to a set
        Set<Id> accountIds = new Set<Id>();
        for (Account account: accounts){
            accountIds.add(account.Id);    
        }
        // Quering Tasks related to Accounts
        tasks =  [SELECT Id, Status, WhatID FROM Task WHERE WhatId IN :accountIds];
        // Putting Tasks to a map 
        Map<Id, List<Task>> accountsIdsWithTasks = new Map<Id, List<Task>>();
        for (Task task : tasks){
            if (accountsIdsWithTasks.containsKey(task.WhatId)){
                accountsIdsWithTasks.get(task.WhatId).add(task);
            } else {
                accountsIdsWithTasks.put(task.WhatId, new List<Task>{task});
            }
        }
        //tasks.clear(); // Cleaning up
        List<Task> taskToUpdate = new List<Task>();
        for (Id id : accountsIdsWithTasks.keySet()){
            if (accountsIdsWithTasks.get(id).size() >=3){
                for (Task task : accountsIdsWithTasks.get(id)){
        	    task.WhatId = null;             // deassigning Task from an Account
                    task.OwnerId = randomUser.Id;   // assigning To The Random User
                    taskToUpdate.add(task);
                }
            }
        }
        update taskToUpdate;
    }
}
