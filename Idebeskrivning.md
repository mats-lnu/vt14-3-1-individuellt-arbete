Individuellt arbete - Svante Arvedson

## Problembeskrivning/Id�beskrivning
### Problem
Svante Arvedson arbetar som musiker och har en stor m�ngd noth�ften hemma. 
Det sista �ret har notsamlingen v�xt mycket och det nuvarande systemet f�r 
att administrera samlingen �r inte l�ngre dimensionerat f�r m�ngden noter, 
med resultatet att Svante har sv�rt att h�lla ordning p� noth�ftena. En 
databas skulle hj�lpa Svante att f� b�ttre koll p� sina noter.
### Beskrivning
I databasen ska Svante kunna registrera sina noter. Till ett noth�fte ska 
information om titel, komposit�r, genre, instrumentation, huvudtonart, 
kompositions�r och utgivnings�r. �ven information om vilket notf�rlag och 
vilken edit�r som har gett ut noten ska finnas med och det ska finnas en 
m�jlighet att skriva anteckningar till varje noth�fte. Det h�nder ibland 
att Svante l�nar ut sina noter, d�rf�r ska det ocks� finnas en m�jlighet 
att notera vilka noter �r utl�nade och till vem.
### Begr�nsning
I det individuellt arbete kommer ett gr�nssnitt och funktionalitet mot tre 
av tabellerna i databasen att implementeras. Det g�ller tabeller f�r 
noth�ften (*Booklet*), f�r musikstycke (*Piece*) och f�r inneh�ll i ett 
noth�tfte (*BookletContent*).

## Fysisk datamodell
<img scr="Bilder/AppDiagram.png" />

## Exempeldata
### Piece
<table>
	<tr>
		<th>PieceID</th>
		<th>Name</th>
		<th>CatalogueNumber</th>
		<th>ComposerID</th>
		<th>KeyID</th>
		<th>GenreID</th>
		<th>YearOfComposition</th>
	</tr>
	<tr>
		<td>1</td>
		<td>Blockfl�jtssonat</td>
		<td>HWV 369</td>
		<td>2</td>
		<td>6</td>
		<td>3</td>
		<td>1725-01-01 00:00:00</td>
	</tr>
	<tr>
		<td>2</td>
		<td>Blockfl�jtssonat</td>
		<td>TWV 41:C5</td>
		<td>3</td>
		<td>5</td>
		<td>3</td>
		<td>1740-01-01 00:00:00</td>
	</tr>
</table>

### Booklet
<table>
	<tr>
		<th>BookletID</th>
		<th>Name</th>
		<th>PublisherID</th>
		<th>YearOfPublication</th>
	</tr>
	<tr>
		<td>3</td>
		<td>Vier Sonaten aus Der getreue Musikmeister</td>
		<td>2</td>
		<td>1969-01-01 00:00:00</td>
	</tr>
	<tr>
		<td>4</td>
		<td>Complete Recorder Sonatas</td>
		<td>3</td>
		<td>1978-01-01 00:00:00</td>
	</tr>
</table>

### BookletContent
<table>
	<tr>
		<th>BookletID</th>
		<th>PieceID</th>
	</tr>
	<tr>
		<td>3</td>
		<td>2</td>
	</tr>
	<tr>
		<td>4</td>
		<td>1</td>
	</tr>
</table>

## Mockup
### Noth�fte, lista
Noth�ftena visas i en lista. M�jlighet att v�lja en post f�r att visa/redigera 
detaljer och m�jlighet att �ppna ett formul�r f�r att l�gga till en ny post.  
<img src="Bilder/Skiss-Lista-pa-nothaften.png" />

### Noth�fte, detaljvy
Ett noth�ftes detaljer visas/redigeras i en seperat vy. Samma utformning anv�nds 
f�r att visa ett noth�fte, redigera ett noth�fte och f�r att l�gga till ett nytt 
noth�fte.  
<img src="Bilder/Skiss-Detaljer-om-nothafte.png" />