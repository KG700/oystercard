# README
## Oystercard project.

## Monday 24th Feb working with Kate

### Step 1
Setup project directory, create GitHub repo and link project directory/git/github.
This part is fairly familliar now so I have done it with minimal trouble/assistance although did need Kate to help with "git clone" vs "git remote add origin ...SSH code thing..."

Done

### Step 2
Create GemFile etc.

run "gem list"
check if 'bundler' is there\
run bundle init - creates empty gemfile ready for me to add info to.
 - added info as per Kate's research (while I was away) should research this a little myself.

 run "bundle"

 - adds gemfile.lock to project dir.

Done

### Step 3
Create file that has the spec naming convention (in the spec file etc.)
prepare first rspec test
run code to pass this test
#### GREEN

### Step 4
attr_reader :variable (list any extra variables after, by comma)\
this makes a 'window' in the object that allows other objects to see inside and 'read' the value of a/the specified variable. \
poke around online/google/relish for resources to help with rspec syntax when forming the tests. It's important to have the test run correctly so that we know the 'failure' is to do with the code failing, not the rspec being written incorrectly.

#### User story
```
In order to use public transport\
As a customer\
I want money on my card\
```

complete; can now see money on card. (at the moment it's only £0.00)

-refactored.

### Step 5
#### User story
```
In order to keep using public transport
As a customer
I want to add money to my card
```

Complete, can now add money to the card.

Instance variables:
are spefic to an instance of a class. johns_card has a variable @balance and kates_card also has a variable @balance but they can be different values; theyre still refered to as '@balance'
we would be able to read the instance variable from from outside the instance they belong to by using attr_reader (look up getter methods and setter methods for more info)

Further updates\
added extra test in line with the 'hint' in the project information.

### Step 6
#### User story
```
In order to protect my money from theft or loss
As a customer
I want a maximum limit (of £90) on my card
```
Added the limiting factor into the top_up method. Iincluded it as a constant (aka magic number) and interpolated the constant into the error codes thrown when top up tries to exceed £90.

## Tuesday 25th Feb working with Kuba

### Step 7
#### User story
```
In order to pay for my journey
As a customer
I need my fare deducted from my card
```

check 'subject' syntax in rspec - an alternative to creating a .new before/during each test.\
within a class 'subject' can potentially be used as shorthand for Class.new (refers to the most recently referenced class.)\

The proess to add the new test and method followed a very similar pattern to the top up balance method. \
had to take care to remember to first create a new card and then add alance to it before the attempt to deduct. \
take care to separate the testing into 'describe' blocks relevant to each suite of testing (per method) remember to check out the correct syntax for refering to a method inrspec - using the `"#method"` syntax.

### Step 8
#### User story
```
In order to get through the barriers.
As a customer
I need to touch in and out.
```

more investigation into the 'subject' nomenclature.

it seems like adding variables to the att_reader (and .initialize) means that we can kind of use variables as methods? investigate this. \
it was hard to separate the creation of in_journey_status as a variable from the defining of .touch_in, try to think/find if there may have been a better approach for this?

still not added .touch_out; will do this next.

getting a warning in IRB:
```
warning: already initialized constant
```
try to figure this out. it seems to not like the existance of the constant while rspec does not like the multiple uses of the constant in the various string interpolations.

.touch_out done.

## Wednesday 26th Feb working with Karla
### Step 9
#### User story
```
In order to pay for my journey
As a customer
I need to have the minimum amount (£1) for a single journey.
```

look up "instance variable set" in rspec syntax\
raised error for minimum balance error for touching in with less than £1\

Take care when setting values using instance_variable_set and/or calling methods. need consistency otherwise you will need one hour and/or one Karla to debug.

Difficulty with defining the test in the first instance because we had to think of how to define a failing feature test while the program *was* working while it should not work.

### Step 10
#### User story
```
In order to pay for my journey
As a customer
When my journey is complete, I need the correct amount deducted from my card
```

This one was driven by Karla. It seemed straightforward to complete. added extera functionality to .touch_out to allow fare to be deducted at end of journey.

learned about `send` which allows us to "invoke" `.privatemethod` without actually 'calling' it. kind of. \
used new rspec syntax `expect {}.to change{}.by()`.\
need to remember to be careful about the +ve or -ve nature of the number we are changing by.

### Step 11
#### User story
```
In order to pay for my journey
As a customer
I need to know where I've travelled from
```
