Subway System
============

Ruby project for mapping the NYC subway network and calculating transit times. To calculate an optimum route, the take train method uses a Dijkstra shortest path algorithm using a min-priority queue implemented by a Fibonacci heap. 

The time complexity of this approach is O(Edges + Vertices*log(Vertices)). The original Djikstra algorithm without the use of the priority queue has a complexity of O(Vertices^2). NYC has 468 subway stops, and assuming an average of 4 possible destinations per station, that gives 1872 edges. This gives a O(1872 + 468(log(468))) = O(3121) computations. Whereas the simplied approach would have O(468^2) = O(219024). For this reason, I chose the min-priority queue approach.

I also considered using an A* approach, but this would require a heuristic function. The heuristic function could work if our map was supplied with additional data, for example Latitude/Longitude coordinates. Without additional data, it is impossible to use a more advanced path finding algorithm, as a heuristic function needs information to function.

Another approach I looked into was the D*, and D*Lite approach. This algorithm recalculates the route as you travel along the vertices, by recalculating edge weights takeing in all present information. This approach would be useful if edge times were subject to change, for example, you could be automatically rerouted during travel if a train was delayed. 


Requirements
-----------
    $ gem install PriorityQueue
    $ gem install rspec


Running the code
-----------
There are two directories, lib, and spec. spec contains the RSpec tests, and lib has the actual ruby files. 

To run the RSpec tests, navigate to the root directory and run:

    $ rspec

To test the code, modify a test in the subwaysystem_spec.rb file, or create a .rb file in the lib directory. 

Create a SubwaySystem object with 
```ruby
    s = SubwaySystem.new
```
---

There are two main methods:
```ruby
    add_train_line (stops, name)
```
Example input:
```ruby
    s.add_train_line(stops=["Canal", "Houston", "Christopher", "14th"], name="1")
    s.add_train_line(stops=["Spring", "West 4th", "14th", "23rd"], name="E")
```
You may also initialize this method with an array of time between stations, then
```ruby
    s.add_train_line(stops=["Canal", "Houston", "Christopher", "14th"], name="1",
                        time_between_stations=[ ["Canal", "Houston", 3],
                                                ["Houston", "Christopher", 7],
                                                ["Christopher", "14th", 2]
                                                ])
```
---
```ruby
    take_train (origin, destination)
```
Example input:
```ruby
    s.take_train(origin="Houston", destination="23rd")
    # returns ["Houston", "Christopher", "14th", "23rd"]
```
Alternatively, if you added a train line with time between stations, then 
```ruby
    s.take_train(origin="Houston", destination="23rd")
    # returns [["Houston", "Christopher", "14th", "23rd"], 11]
```

