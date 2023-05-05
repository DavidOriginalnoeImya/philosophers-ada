with Ada.Text_IO;
use Ada.Text_IO;

procedure Philosophersproblem is

   task Servant is
      entry giveForks(philosopherIndex: Integer; canEat: out Boolean);
      entry getForks(philosopherIndex: Integer);
   end Servant;

   task body Servant is
      forks: array(0..4) of Boolean := (false, false, false, false, false);
   begin
      loop
         select
            accept giveForks(philosopherIndex: Integer; canEat: out Boolean) do
               canEat := false;
               if (not forks(philosopherIndex))
                 and (not forks((philosopherIndex + 1) mod 5)) then
                  forks(philosopherIndex) := true;
                  forks((philosopherIndex + 1) mod 5) := true;
                  canEat := true;
               end if;
            end giveForks;
         or
            accept getForks (philosopherIndex : Integer) do
               forks(philosopherIndex) := false;
               forks((philosopherIndex + 1) mod 5) := false;
            end getForks;
         end select;
      end loop;
   end Servant;

   task type Philosopher(index: Integer) is
   end Philosopher;
   task body Philosopher is
      canEat: Boolean := false;
   begin
      loop
         --  Put_Line("Philosopher " & Integer'Image(index) & " is thinking");

         delay 3.0;

         --  Put_Line("Philosopher " & Integer'Image(index) & " is trying to eat");

         Servant.giveForks(index, canEat);

         if canEat then
            Put_Line("Philosopher " & Integer'Image(index + 1) & " is eating");

            delay 3.0;

            Put_Line("Philosopher " & Integer'Image(index + 1) & " has done eating");

            Servant.getForks(index);
         end if;

      end loop;
   end Philosopher;

   philosopher1: Philosopher(0);
   philosopher2: Philosopher(1);
   philosopher3: Philosopher(2);
   philosopher4: Philosopher(3);
   philosopher5: Philosopher(4);


begin
   --  Insert code here.
   null;
end Philosophersproblem;
