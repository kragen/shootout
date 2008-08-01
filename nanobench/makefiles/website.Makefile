# The Computer Language Benchmarks Game
# $Id: website.Makefile,v 1.3 2008-08-01 07:03:48 igouy-guest Exp $


# Copy new log files to the sweep directory
# Create highlight markup for new program source and copy to the sweep directory


.PHONY: logs highlight


# _LOGS are the files we have, if they change we want LOGS to change

_LOGS = $(wildcard *_log)

# we make LOGS by substituting the suffixes

LOGS = $(_LOGS:_log=.log)

# the target we call wants to make just LOGS which are out of date
# if there's a CODE_SWEEP cp all *.log preserving their timestamps

ifneq (($strip $(LOG_SWEEP)),)
   logs: $(LOGS)
	-@cp -pu *.log $(LOG_SWEEP) 
else
   logs: $(LOGS)
	-@echo no log sweep
endif

# the pattern for each LOGS suffix matches a _LOGS file on which 
# it is dependent so copy and rename that _LOGS file

%.log: %_log
	@cp $< $@




# _SRCS are the files we have, if they change we want SRCS to change

_SRCS = $(wildcard *_code)

# we make SRCS by substituting the suffix we want .code for _code

SRCS = $(_SRCS:_code=.code)

# the target we call wants to make just SRCS which are out of date
# if there's a CODE_SWEEP cp all *.code preserving their timestamps

ifneq (($strip $(CODE_SWEEP)),)
   highlight: $(SRCS)
	-@cp -pu *.code $(CODE_SWEEP) 
else
   highlight: $(SRCS)
	-@echo no highlight sweep
endif

# the pattern for each SRCS suffix matches a _SRCS file on which 
# it is dependent so use highlight to create xml markup of the source

%.code: %_code
	-@highlight --fragment --xml --add-data-dir=$(NANO_HIGHLIGHT) \
		--add-config-dir=$(NANO_HIGHLIGHT) --force -i $< -o $@ 



