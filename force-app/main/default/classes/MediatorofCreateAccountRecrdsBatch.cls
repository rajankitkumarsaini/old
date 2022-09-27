global class MediatorofCreateAccountRecrdsBatch implements iterable<Account>{
    global Iterator<Account> Iterator(){
        return new AccountGenerator(10);
    }

}