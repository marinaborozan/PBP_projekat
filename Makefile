DIR	=	PBP_projekat
CC	=	gcc
PROGS	=	funkcije.c
OUTPUT	=	projekat
CFLAGS	=	-g	-Wall	`mysql_config --cflags --libs`

.PHONY:		all create trigger insert beauty dist progs

all:	create trigger insert progs

progs:
	$(CC)	-o	$(OUTPUT)	$(PROGS)	$(CFLAGS)

create:
	mysql	-u	root	-p	<Create.sql

trigger:
	mysql	-u	root	-p	<Triger.sql

insert:
	mysql	-u	root	-p	<Insert.sql

beauty:
	-indent $(PROGS)

clean:
	-rm -f *~ $(OUTPUT)

dist: beauty clean
	-tar -zcvf $(DIR).tar.gz $(DIR)
