identifier;
(!!);
123;
Mod.Mod;
[]; (); true; false;
`identifier; `ModuleName;
(1);
begin [@ identifier 123] "abc" end;
begin % when "abc" end;
begin [@ identifier : ;; ] "abc" end;
(*begin [@ identifier : 'identifier ] "abc" end;*)
begin [@ identifier : val a : 'identifier [@@ identifier 123 ]] "abc" end;
begin end;
("abc" : 'identifier);
abc def ~ghi ?klm ?opq:rst ~uvw:xyz;
(let rec f = "a" ; "b"
     and g: 'identifier = 1 in "c");
(let module SimpleModule = Mod.Mod in "abc");
(let exception SimpleException of 'identifier in "abc");
(let open ! SimpleModule in "abc");
(function a -> "a" | b -> "c");
(fun ?(identifier : 'identifier = 123) -> "abc");
(fun ?id:(exception abc | xyz [@ identifier 123] as a :: def, hji as d) -> 123);
(fun ?id: identifier -> 123);
(fun (type a b c) -> "a");
(match "abc" with | a -> 123);
(try 123; "abc" with | a -> 123);
(Mod1.Mod2 abc);
(`identifier "abc");
(`Identifier "abc");
(if true then 1 else 2);
(if true then 1);
(while true do 123 done);
(for i = 1 to 10 do 123 done);
(::)(1, 3);
(1 :: 2 :: 3);
(1 = 2 < 3 > 4);
(1 < 4 :: 2 = 3);
(1 +  2 * 3 / 4 := 5 || 7 & 8 @ 9 ** 2);
(1 + -2);
(a.b <- c)
(a.("abc"; "123") <- b);
(a.["abc"; "123"] <- b)
(a.{b} <- c);
(a <- b);
object
    val mutable virtual x : int
    val virtual mutable y : int
    val mutable z = "hello"
    val w : int = 123
    method private virtual m : 'a 'b . int
    inherit Mod1.Mod2.klass as klassy
    inherit fun a b c -> Mod1.Mod2.klass as klassy
    inherit klass a b
    inherit [klass1, klass2] a b
    inherit (klass a b : identifier)
    inherit ! [@identifier abc] [@identifier 123] [klass1, klass2] a b [@identifier 123]
    inherit (klass a b : object
        (*[@identifier abc] (int)
        val virtual mutable a : int
        constraint int = string*)
        [%% abc : val a: int]
    end) [@identifier abc]
end

let a = 1

external ext : int = "a" "b"

type nonrec 'a simpletype = int constraint int = string

type simpletype +=
    Int of int
    | Float = Float2

exception Ex of int
exception Ex = Ex

module SimpleModule : int = Mod2
module SimpleModule : int = functor (Mod1 : int) -> Mod

module SimpleModule : int = ( val 123 : Mod :> Mod)

class [+'a, -'b] klass a b = klass