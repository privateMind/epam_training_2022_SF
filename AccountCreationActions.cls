public class AccountCreationActions {
@invocableMethod(label='On Account Creation' description='Runs when an account is created')
public static void OnAccountCreation(List<Account> accts){
   List<Task> tasksList = new List<Task>();
   for(Account a: accts){
	Task currentTask = new Task();
    currentTask.Subject = 'Negotiations with ' + a.Name ;
	currentTask.WhatId = a.ID;
    tasksList.add(currentTask);   
   }
   upsert tasksList; 
}
}