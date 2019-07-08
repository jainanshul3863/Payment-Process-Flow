------------------------------------------payment process flow------------------------------------------------
--use PaymentProcessFlow

-------------------------------------------------------PROCEDURE TO CHECK DUPLICATE IDS OR PAYMENT-----------------------
/*
create procedure checkPaymentAndDuplicate
@id int,
@payment float,

as
if @id in (select chart_id from CODINGEXTRACTTABLE where chart_id=@id) or payment=0
return 0
else
return 1
*/

-----------------------------------------PROCEDURE FOR MATCHING CRITERIA1 -------------------------------------------------------------

-----------------------------------------PROCEDURE FOR MATCHING CRITERIA2 ----------------------------------------------

-----------------------------------------PROCEDURE FOR MATCHING CRITERIA3 ----------------------------------------------

-----------------------------------------PROCEDURE FOR MATCHING CRITERIA4 ----------------------------------------------


---------------------------------------------CREATING THE STAGES(1,2,3,4) AND EXCLUSION REPORT AND REJECTEDIDS TABLE---------------------
/*
select * into stage1 from CODINGEXTRACTTABLE where 1=0

select * into stage2 from CODINGEXTRACTTABLE where 1=0

select * into stage2 from CODINGEXTRACTTABLE where 1=0

select * into stage2 from CODINGEXTRACTTABLE where 1=0

select * into EXCLUSION_REPORT from CODINGEXTRACTTABLE where 1=0

select * into RejctedIDS from CODINGEXTRACTTABLE where 1=0
*/

----------------------------------------------- THIS IS THE PARENT PROCEDURE WHICH WILL CALL ALL OTHER PROCEDURES ---------------------------

/*
create procedure PaymentProcessProcedure
@id int,
@payment float,

as
declare
@match1 int,
@match2 int,
@match3 int,
@match4 int,

execute @match1=MatchingCriteria1 @id
if @match1=1
begin
       insert into stage1 select * from CODINGEXTRACTTABLE where chart_id=@id
end

else
begin
       execute @match2=MatchingCriteria2 @id
       if @match2 = 1
        begin
            insert into stage2 select * from CODINGEXTRACTTABLE where chart_id=@id
        end

       else
        begin
             execute @match3=MatchingCriteria3 @id
             if @match3 = 1 
             begin
                  insert into stage3 select * from CODINGEXTRACTTABLE where chart_id=@id
             end

             else
              begin
                execute @match4=MatchingCriteria4 @id
                 if @match4 = 1
                 begin
                      insert into stage4 select * from CODINGEXTRACTTABLE where chart_id=@id
                 end

                 else
                  begin
                     insert into EXCLUSION_REPORT select * from CODINGEXTRACTTABLE where chart_id=@id
                  end

              end
         end
end
*/
------------------------------- THIS CODE IS USED TO CALL THE PARENT PROCEDURE ON EVERY ROW OF CODINGEXTRACTTABLE 

/*
declare
@id int,
@payment float

declare cursor1 CURSOR READ_ONLY
FOR select chart_id,payment From CODINGEXTRACTTABLE

open cursor1

fetch next from cursor1 int @id,@payment
while(@FETCH_STATUS=0)
begin
   execute PaymentProcessProcedure @id,@payment

   fetch next from cursor1 int @id,@payment
end 

close cursor1
deallocate cursor1

*/