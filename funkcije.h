#ifndef FUNKCIJE_H_
#define FUNKCIJE_H_
#include <mysql.h>

#define MAX_QUERY_LENGTH 1024

typedef struct {
	MYSQL *connection;
	MYSQL_RES *result;
	MYSQL_ROW row;
	MYSQL_FIELD *column;
	char query[MAX_QUERY_LENGTH];
}Sql;

#endif
