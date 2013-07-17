unit visualterm;

interface

	uses crt;

	type 
		Point= record
			x,y:integer;
		end;

		LineAverage= record
			avg,last: integer;
		end;
	
	procedure drawSquare(x,y,width,height:integer;character:char);
	procedure drawLine(x1,y1,x2,y2:integer;character:char);

implementation

	procedure drawSquare(x,y,width,height:integer;character:char);
		var 
			i:integer;
		begin
			for i:=x to (x+width) do
			begin
				gotoxy(i,y);
					write(character);
				gotoxy(i,y+height);
					write(character);
			end;

			for i:=y to (y+height) do
			begin
				gotoxy(x,i);
					write(character);
				gotoxy(x+width,i);
					write(character);
			end;
		end;
	
	procedure changeVars(var a,b:integer);
		var 
			aux:integer;
		begin
			aux:=a;
			a:=b;
			b:=aux;
		end;

	procedure descOrder(var a,b:integer);
                begin
                        if a<b then changeVars(a,b)
                end;

	procedure cresOrder(var a,b:integer);
		begin 
			if a>b then changeVars(a,b);
		end;

	function directionAvg(x1,y1,x2,y2:integer): LineAverage;
		var 
			lAvg:LineAverage;
			difX,difY: integer;
		begin
			
			descOrder(x1,x2);
			difX:=x1-x2;
			writeln('difx: ',difX);

			descOrder(y1,y2);
			difY:=Y1-Y2;
			writeln('difY: ',difY);

			descOrder(difY,difX);
			
			if (difY=0) or (difX=0) then 
				begin
					lAvg.avg:=0;
					lAvg.last:=0;
				end
			else
				begin
					lAvg.avg:=difX div difY;
					lAvg.last:=difX mod difY;
				end;

			directionAvg:=lAvg;
		end;

	procedure drawLine(x1,y1,x2,y2:integer;character:char);
		var 
			i: integer;
			la:LineAverage;
		begin
			i:=0;
			la:=directionAvg(x1,y1,x2,y2);

			if (la.avg=0) then 
			begin
			if (x1=x2) then 
				begin
					writeln('1');
					descOrder(y1,y2);
					for i:= y1 to y2 do
					begin
						gotoxy(x1,i);
						write(character);
					end;
				end
			else
				begin 
					writeln('2');
					descOrder(x1,x2);
					for i:= x1 to x2 do
					begin
						gotoxy(i,y1);
						write(character);
					end;
				end;
			end;

			writeln(la.avg);
			writeln(la.last);
		end;
end.
