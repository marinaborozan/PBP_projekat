#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql.h>
#include <error.h>
#include "funkcije.h"

void insertLinija(Sql *sql);
void insertUpravlja(Sql *sql);
void selectBrod(Sql *sql);
void updateTeret(Sql *sql);

int main (){
 Sql sql;
 sql.connection = mysql_init(NULL);
 if (mysql_real_connect(sql.connection, "localhost", "root", "marina", "mydb", 0, NULL, 0) == NULL)
    printf("Konekcija na server - fail.\n");

    int idNum;

    while(1){
      	printf ("%s:\n%s\n%s\n%s\n%s\n%s\n\n",
                "Unesite",
                "1. za dodavanje linije",
                "2. za dodavanje upravljanja",
                "3. za ispis brodova",
                "4. za dodavanje tereta na voznju",
                "5. za kraj");

      	scanf("%d",&idNum);
        switch (idNum) {
          	case 1:
            		insertLinija(&sql);
            		break;
          	case 2:
            		insertUpravlja(&sql);
            		break;
          	case 3:
            		selectBrod(&sql);
            		break;
          	case 4:
            		updateTeret(&sql);
            		break;
          	case 5:
        		exit(EXIT_SUCCESS);
        	default:
        	  printf ("Greska - unesite broj 1-5 za izvrsavanje upita\n");
          }
  }
 return 0;
}
void insertLinija(Sql *sql){
	printf("Unesi: identifikator linije, destinaciju, kilometrazu:\n");
	int id;
	char* dest;
	double km;
  	scanf("%d%ms%lf",&id,&dest,&km);
  	sprintf(sql->query,"insert into Linija(idLinija,Destinacija,Kilometraza) values (%d,'%s',%f);",id,dest,km);

  	if (mysql_query(sql->connection, sql->query)) {
    		printf ("insertLinija fail\n");
    		exit (EXIT_FAILURE);
  	}

  	free(dest);
}
void insertUpravlja(Sql *sql){
	printf("Unesi: identifikator broda, identifikator kapetana, datum pocetka upravljanja, datum zavrsetka upravljanja:\n");
	int idB, idK;
	char* pocetak;
	char* kraj;
  	scanf("%d%d%ms%ms",&idB,&idK,&pocetak,&kraj);
  	sprintf (sql->query, "insert into Upravlja(Brod_idBrod,Kapetan_idKapetan,Pocetak_upravljanja,Zavrsetak_upravljanja) values (%d,%d,'%s','%s');", idB,idK,pocetak,kraj);

  	if (mysql_query(sql->connection, sql->query)) {
   		printf ("insertUpravlja fail\n");
   		exit (EXIT_FAILURE);
  	}

	free(pocetak);
	free(kraj);
}
void selectBrod(Sql *sql){
  sprintf (sql->query, "select * from Brod;");
  if (mysql_query(sql->connection, sql->query)) {
    printf ("selectBrod fail\n");
    exit (EXIT_FAILURE);
  }

  sql->result = mysql_use_result(sql->connection);
  sql->column = mysql_fetch_fields(sql->result);

  int n = mysql_field_count(sql->connection);
  int i;
  for (i=0;i<n;i++) {
    printf ("%s\t", sql->column[i].name);
  }
  printf ("\n");

  while ((sql->row = mysql_fetch_row(sql->result))) {
    int j;
    for (j=0;j<n;j++){
      printf ("%s\t", sql->row[j]);
    }
    printf ("\n");
  }
  printf ("\n");
}
void updateTeret(Sql *sql){
	printf("Unesi: identifikator tereta, identifikator broda(voznja), identifikator linije(voznja):\n");
	int idT, idB, idL;
  	scanf("%d%d%d",&idT,&idB,&idL);
  	sprintf (sql->query, "update Teret set Voznja_Brod_idBrod = %d, Voznja_Linija_idLinija = %d where idTeret = %d;", idB,idL,idT);

  	if (mysql_query(sql->connection, sql->query)) {
   		printf ("updateTeret fail\n");
   		exit (EXIT_FAILURE);
  	}
}
