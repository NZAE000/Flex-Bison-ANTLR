APP := exec
CTX := calcu
VERSION := v1
CC		:= gcc
UTILPATH := util
UTILSRC	 := $(shell find $(UTILPATH) -type f -iname "*.c")
INCLUDEPATH := -I .
LIBS		:= -ll


# target : dependences
# rules

.PHONY : clean cleanall

$(APP) : src_bison src_flex
	$(CC) $(INCLUDEPATH) $(VERSION)/*.c $(UTILSRC) $(LIBS) -o $(APP)


src_bison : $(VERSION)/$(CTX).y
	bison -d $^
	mv $(CTX).tab.* $(VERSION)


src_flex : $(VERSION)/$(CTX).l
	flex -o $(CTX).yy.c $^
	mv $(CTX).yy.c $(VERSION)


clean:
	rm $(VERSION)/calcu.tab.c
	rm $(VERSION)/calcu.yy.c
	rm $(VERSION)/calcu.tab.h

cleanall:
	rm $(VERSION)/calcu.tab.c
	rm $(VERSION)/calcu.yy.c
	rm $(VERSION)/calcu.tab.h
	rm $(APP)