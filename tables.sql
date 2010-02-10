CREATE TABLE deck (
	colour INTEGER,
	symbol INTEGER,
	number INTEGER,
	fill INTEGER,
	PRIMARY KEY (colour, symbol, number, fill)
);

CREATE TABLE board (
	colour INTEGER,
	symbol INTEGER,
	number INTEGER,
	fill INTEGER,
	PRIMARY KEY (colour, symbol, number, fill)
);

CREATE TABLE details (
	score INTEGER,
	label_msg VARCHAR(40)
);