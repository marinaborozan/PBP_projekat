use `mydb`;
delimiter $$

drop trigger if exists bi_Upravlja $$
create trigger bi_Upravlja before insert on Upravlja
for each row
begin
	if(
		exists(
			select * from Upravlja u 
			where u.Kapetan_idKapetan = new.Kapetan_idKapetan
			and 
			((new.Pocetak_upravljanja <= u.Pocetak_upravljanja && new.Zavrsetak_upravljanja >= u.Pocetak_upravljanja)
			or
			(new.Pocetak_upravljanja <= u.Zavrsetak_upravljanja && new.Zavrsetak_upravljanja >= u.Zavrsetak_upravljanja)
			or
			(new.Pocetak_upravljanja >= u.Pocetak_upravljanja && new.Zavrsetak_upravljanja <= u.Zavrsetak_upravljanja))
		)
	)
	then
		SIGNAL SQLSTATE '45000' SET message_text = 'Kapetan je zauzet u datom periodu';
	end if;
	if(
		exists(
			select * from Voznja v 
			where v.Brod_idBrod = new.Brod_idBrod
			and
			((new.Pocetak_upravljanja <= v.Vreme_polaska && new.Zavrsetak_upravljanja >= v.Vreme_polaska)
			or
			(new.Pocetak_upravljanja <= v.Vreme_dolaska && new.Zavrsetak_upravljanja >= v.Vreme_dolaska)
			or
			(new.Pocetak_upravljanja >= v.Vreme_polaska && new.Zavrsetak_upravljanja <= v.Vreme_dolaska)) 
		)
	)
	then
		SIGNAL SQLSTATE '45000' SET message_text = 'Brod je zauzet u datom periodu';
	end if;
end $$

drop trigger if exists bu_Teret $$
create trigger bu_Teret before update on Teret
for each row
begin
	if(
		select new.Tezina(kg) > (select max(Kapacitet(kg)) from Brod)
	)
	then
		SIGNAL SQLSTATE '45000' SET message_text = 'Teret je tezi od max kapacitet brodova';
	end if;
end $$

delimiter ;
