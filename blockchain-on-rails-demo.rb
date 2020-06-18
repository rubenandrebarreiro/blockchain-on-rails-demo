# BLOCKCHAIN ON RAILS DEMO

# Description:
# - A simple Demo for a Blockchain, in Ruby on Rails;

# Author:
# - Ruben Andre Barreiro
# - Computer Science/Engineering

#!/usr/bin/ruby -w


puts "\n\n\n-- WELCOME TO THE BLOCKCHAIN ON RAILS DEMO --\n\n";


class Client
    
    @@no_of_clients = 0
    def initialize(id, first_name, last_name)
        @client_id = id
        @client_first_name = first_name
        @client_last_name = last_name
        @client_money_balance = 0.0
        @client_gems = 0.0
    end

    def get_client_id()
        
       @client_id 
    
    end

    def get_client_first_name()
        
       @client_first_name 
    
    end

    def get_client_last_name()
        
       @client_last_name 
    
    end

    def get_client_money_balance()
        
       @client_money_balance 
    
    end
    
    def set_client_money_balance(client_new_money_balance)
    
        @client_money_balance = client_new_money_balance
    
    end

    def get_client_gems()
        
       @client_gems
    
    end
    
    def set_client_gems(client_new_gems)
    
        @client_gems = client_new_gems
    
    end
    
end


# Array of Registered Clients
clients = Array.new


# Array of Transactions
transactions = Array.new

# Array of Opened Transactions
opened_transactions = Array.new

# Array of Closed Transactions
closed_transactions = Array.new


# Array of Mined Blocks
mined_blocks = Array.new


$choice = -1

while(true) do
    
    # Main Menu - Choose Option
    while $choice < 0 or $choice > 12  do
        
        puts("Please, choose an option, from the following:\n\n")
        
        puts("0) Create a Client;")
        
        puts("1) Deposit Money for a Client; [NOTE: Just For Fun/Debug]")
        puts("2) Withdraw Money for a Client; [NOTE: Just For Fun/Debug]")
        puts("3) Transfer Money between Clients; [NOTE: Just For Fun/Debug]")
        
        puts("4) Deposit Gems for a Client; [NOTE: Just For Fun/Debug]")
        puts("5) Withdraw Gems for a Client; [NOTE: Just For Fun/Debug]")
        puts("6) Transfer Gems between Clients; [NOTE: Just For Fun/Debug]")
        
        puts("7) Create a Transaction;")
        puts("8) Create and Try to Solve a Block of Transactions;")
        
        puts("9) List all the Registered Clients;")
        puts("10) List all the Transactions;")
        puts("11) List all the Closed/Mined Blocks;")
        
        puts("12) Exit/Quit")
        
        puts("\n\n")
        
        $choice = gets.chomp.to_i
        puts("\n\n")
        
    end
    
    
    # Chosen Option #0 - Create Client
    if($choice == 0)
        
        $client_id = clients.length
        $client_first_name = -1
        $client_last_name = -1
        
        puts("Choose the First Name for the Client:")
        $client_first_name = gets.chomp
        puts("\n\n")
        
        puts("Choose the Last Name for the Client:")
        $client_last_name = gets.chomp
        puts("\n\n")
        
        $new_client = Client.new($client_id, $client_first_name, $client_last_name)
        
        clients.push($new_client)
        
        puts("\nClient created successfully!!!")
        
        $choice = -1
        
    end
    
    
    # Chosen Option #1 - Deposit Money for a Client
    if($choice == 1)
        
        $client_found = false
        
        $client_id = -1
        $client_money_amount_deposit = -1
        
        puts("Choose the Client ID:")
        $client_id = gets.chomp.to_i
        puts("\n\n")
        
        puts("Choose the Money Amount to be Deposited:")
        $client_money_amount_deposit = gets.chomp.to_f
        puts("\n\n")
        
        clients.each do |client|
           
            if(client.get_client_id == $client_id)
               
                $client_old_amount = client.get_client_money_balance
                
                $client_new_amount = $client_old_amount + $client_money_amount_deposit
                
                client.set_client_money_balance($client_new_amount)
                
                $client_found = true
                
            end
            
        end
        
        if($client_found == true)
            puts("\nClient deposited %0.2f EUR successfully!!!" % [$client_money_amount_deposit])
        else
            puts("\nClient with the given ID not found!!!")
        end
            
        $choice = -1
        
    end
    
    
    # Chosen Option #2 - Withdraw Money for a Client
    if($choice == 2)
        $client_found = false
        
        $client_id = -1
        $client_money_amount_withraw = -1
        $client_old_amount = -1
        
        puts("Choose the Client ID:")
        $client_id = gets.chomp.to_i
        puts("\n\n")
        
        puts("Choose the Money Amount to be Withdrawn:")
        $client_money_amount_withraw = gets.chomp.to_f
        puts("\n\n")
        
        clients.each do |client|
           
            if(client.get_client_id == $client_id)
               
                $client_old_amount = client.get_client_money_balance
                
                if( ($client_old_amount - $client_money_amount_withraw) >= 0)
                
                    $client_new_amount = $client_old_amount - $client_money_amount_withraw
                    client.set_client_money_balance($client_new_amount)
                
                end
                
                $client_found = true
            
            end
            
        end
        
        if($client_found == true)
           
            if( ($client_old_amount - $client_money_amount_withraw) < 0)
            
                puts("\nClient don't have the necessary Money Amount Balance to do this operation!!!")
            
            else
            
                puts("\nClient withrawn %0.2f EUR successfully!!!" % [$client_money_amount_withraw])
        
            end
        
        else
        
            puts("\nClient with the given ID not found!!!")
        
        end
            
        $choice = -1
        
    end
    
    
    # Chosen Option #3 - Transfer Money between Clients
    if($choice == 3)
        
        $client_from_found = false
        $client_to_found = false
        
        $client_from_id = -1
        $client_to_id = -1
        $client_money_amount_transfer = -1
        $client_from_old_amount = -1
        $client_to_old_amount = -1
        
        puts("Choose the FROM Client ID:")
        $client_from_id = gets.chomp.to_i
        puts("\n\n")
        
        puts("Choose the TO Client ID:")
        $client_to_id = gets.chomp.to_i
        puts("\n\n")
        
        puts("Choose the Money Amount to be Transferred:")
        $client_money_amount_transfer = gets.chomp.to_f
        puts("\n\n")
        
        clients.each do |client_from|
           
            if(client_from.get_client_id == $client_from_id)
               
                clients.each do |client_to|
           
                    if(client_to.get_client_id == $client_to_id)
                        
                        $client_from_old_amount = client_from.get_client_money_balance
                
                        if( ($client_from_old_amount - $client_money_amount_transfer) >= 0)

                            $client_from_new_amount = $client_from_old_amount - $client_money_amount_transfer
                            client_from.set_client_money_balance($client_from_new_amount)

                            $client_to_new_amount = $client_to_old_amount + $client_money_amount_transfer
                            client_to.set_client_money_balance($client_to_new_amount)
                            
                        end
                        
                        $client_to_found = true
                        
                    end
                    
                end
                
                $client_from_found = true
                
            end
            
        end
                
        
        if($client_from_found == true)
           
            if($client_to_found == true)

                if( ($client_from_old_amount - $client_money_amount_transfer) < 0)
            
                    puts("\nClient FROM don't have the necessary Money Amount Balance to do this operation!!!")

                else

                    puts("\nClient Transferred %0.2f EUR successfully!!!" % [$client_money_amount_transfer])

                end    

            else

                puts("\nClient TO with the given ID not found!!!")

            end 
            
        else
        
            puts("\nClient FROM with the given ID not found!!!")
        
        end    
        
            
        $choice = -1
        
    end
    
    
    # Chosen Option #9 - Exit/Quit
    if($choice == 9)
        
        if(clients.length == 0)
            puts("No Clients registered in the system yet...")
        else
            puts("All the Clients registered in the system:\n\n")
        end
            
        $client_num = 1
        clients.each do |client|
            
            puts("Client #%d: {\n" % [$client_num])
            puts("  ID: %d\n" % [client.get_client_id])
            puts("  First Name: %s\n" % [client.get_client_first_name])
            puts("  Last Name: %s\n" % [client.get_client_last_name])
            puts("  Money Amount Balance: %0.2f EUR\n" % [client.get_client_money_balance])
            puts("}")
            
            $client_num = $client_num + 1
            
            puts("\n\n")
            
        end
        
        $choice = -1
        
    end
    
    if($choice == 12)
        
        exit
    
    end
    
    puts "\n\n\n"
    
end