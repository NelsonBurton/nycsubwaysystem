Subway System
============

Ruby project for mapping the NYC subway network and calculating transit times. 


Requirements
-----------
    $ gem install PriorityQueue
    $ gem install rspec


Running the code
-----------
There are two directories, lib, and spec. Spec contains the RSpec tests, and lib has the actual ruby files. 

To run the RSpec tests, navigate to the root directory and run:

    $ rspec

To test the code, modify a test in the subwaysystem_spec.rb file, or create a .rb file in the lib directory. 

Create a SubwaySystem object with 

    s = SubwaySystem.new

There are two main methods:

---
    add_train_line (stops, name)

Example input:

    s.add_train_line(stops=["Canal", "Houston", "Christopher", "14th"], name="1")
    s.add_train_line(stops=["Spring", "West 4th", "14th", "23rd"], name="E")

You may also initialize this method with an array of time between stations.

    s.add_train_line(stops=["Canal", "Houston", "Christopher", "14th"], name="1",
                        time_between_stations=[ ["Canal", "Houston", 3],
                                                ["Houston", "Christopher", 7],
                                                ["Christopher", "14th", 2]
                                                ])

---
    take_train (origin, destination)

Example input:

    s.take_train(origin="Houston", destination="23rd")
    # returns ["Houston", "Christopher", "14th", "23rd"]

Alternatively, if you added a train line with time between stations, then 

    s.take_train(origin="Houston", destination="23rd")
    # returns [["Houston", "Christopher", "14th", "23rd"], 11]
