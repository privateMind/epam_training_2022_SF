public class AccountUpdateActions {
	@invocableMethod(label='On Account Updation' description='Runs when an account is updated')
	public static void OnAccountUpdation (List<Account> accts) {
        List <Task> accountTasks;
        // Query active users to list
        List <User> activeUsers = [SELECT Id,Name FROM User WHERE IsActive=true]; 
        // Selecting random user from a list
		User randomUser = activeUsers [ Integer.valueof (Math.random() * (activeUsers.size() - 1)) ];
        for (Account a: accts){
                accountTasks =  [SELECT Id, Status, WhatID FROM Task WHERE WhatId = : a.Id ];
                if (accountTasks.size() >= 3){
                    for (Task t:accountTasks){
                        t.WhatId = null;             // deassigning Task from an Account
                        t.OwnerId = randomUser.Id;   // assigning To The Random User
                    }//for
                }//if
        }
        update accountTasks;
    }
}