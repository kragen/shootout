# The Computer Language Shootout
# http://shootout.alioth.debian.org/
# Contributed by Andrew McParland

package require Thread

proc meeting_place {} {
    thread::create {
        proc init {meetings} {
            global meetings_left first
            set meetings_left $meetings
            set first 1
        }
        # Process the request to meet
        proc meet {tid colour} {
            global meetings_left first first_colour first_tid
            if {$meetings_left == 0} {
                thread::send -async $tid [list met "Faded"]
            } else {
                if {$first} {
                    set first_tid $tid
                    set first_colour $colour
                    set first 0
                } else {
                    # Tell the 2 creatures the colour of the other creature
                    thread::send -async $first_tid [list met $colour]
                    thread::send -async $tid [list met $first_colour]
                    incr meetings_left -1
                    set first 1
                }
            }
        }
        thread::wait
    }
}

proc create_creature {} {
    thread::create -joinable {
        proc start {initial_colour MeetingPlaceId} {
            global colour MeetingPlace meetings
            set colour $initial_colour
            set MeetingPlace $MeetingPlaceId
            set meetings 0
            # Start the meeting process
            thread::send -async $MeetingPlace [list meet [thread::id] $colour]
        }
        # Called when met another creature
        proc met {col} {
            global meetings MeetingPlace colour
            if {$col ne "Faded"} {
                set colour [change_colour $colour $col]
                incr meetings
                # Request another meeting
                thread::send -async $MeetingPlace [list meet [thread::id] $colour]
            } else {
                # Fade away...
                tsv::incr creatures sum $meetings
                thread::release
            }
        }
        proc change_colour {col1 col2} {
            if {$col1 eq $col2} {return $col1}
            switch $col1 {
                "Blue" {return [expr {$col2 eq "Red" ? "Yellow" : "Red"}]}
                "Red" {return [expr {$col2 eq "Blue" ? "Yellow" : "Blue"}]}
                "Yellow" {return [expr {$col2 eq "Blue" ? "Red" : "Blue"}]}
                default {return $col1}
            }
        }
        thread::wait
    }
}

# Initialise thread-shared sum of creatures met
tsv::set creatures sum 0

# Create the meeting place thread
set MeetingPlace [meeting_place]

set colours [list Blue Red Yellow Blue]

# Start the creature threads
foreach c $colours {
    lappend threads [create_creature]
}

# Initialise the meeting place and start each creature
thread::send $MeetingPlace [list init [lindex $argv 0]]
foreach t $threads c $colours {
    thread::send $t [list start $c $MeetingPlace]
}

# Wait for the creature threads to finish
foreach t $threads {
    thread::join $t
}

# Print sum of meetings
puts [tsv::set creatures sum]
