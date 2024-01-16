stabs:=function(G);			
A:=AutomorphismGroup(G); ng:=Ngens(A);
	prep,P:=PermutationRepresentation(A);
	assert ng eq Ngens(P) and forall{i: i in [1..ng] | A.i @ prep eq P.i};
	Gprime:=[Stabiliser(G,1)]; //images of Stab(G,1) under automorphisms
	perms:=[[]: i in [1..ng]];  //permutations of Gprime induced by A.i
	j:=1;
	while j le #Gprime do
		S:=Gprime[j];
		for i in [1..ng] do
			im:=(A.i)(S);
			pos:=Position(Gprime,im);
			if pos eq 0 then //new image
				Append(~Gprime,im);
				pos:=#Gprime;
			end if;
			Append(~perms[i],pos);
		end for;
		j:=j+1;
	end while;
return Gprime;
end function;

parallel_HGS_type:=function(n);
	trans:=[];
	for A in SmallGroups(n) do
		hol:=Holomorph(A);
		t:=Subgroups(hol:OrderMultipleOf:=n,IsTransitive:=true);
		t_groups:=[[*G`subgroup,A*] : G in t];
		trans := trans cat t_groups;
	end for;
	data:=[];
	for G in trans do;
		exists_HGS:=[];
		a:=Order(G[1])/n;
		a:=Round(a);
		if a gt 1 then
			index_n:=Subgroups(G[1] : OrderEqual :=a);
			for H in index_n do
				Hsub:=H`subgroup;
				C:=Core(G[1],Hsub);
				if IsTrivial(C) eq false then
						//now we need to see Hsub/C as a subgroup of G/C
					J,pi:=quo<G[1]|Generators(C)>;													//pi gives the canonical map from G to G/C:=J
					f:=hom<Hsub-> G[1] | SetToSequence(Generators(Hsub)) >; 						//f gives the inclusion map from Hsub to G
					if IsHomomorphism(f) then													//for some reason, MAGMA thinks that f is not a homomorphism on occasion...
						Jprime:=Image(f*pi); 													//Jprime:=Hsub/C is identified as a subgroup of G/C
						exists_isom:=false;
						i:=1;
						while exists_isom eq false and i le #trans do
							bool,isom:=IsIsomorphic(J,trans[i][1]);
							if bool eq true then
								if Position(stabs(trans[i][1]),isom(Jprime)) gt 0 then
									exists_isom:=true;
								end if;
							end if;
							i:=i+1;
						end while;
					end if;
				else
					exists_isom:=true;
				end if;
				if exists_isom eq false then
					Append(~exists_HGS,exists_isom);
				end if;
			end for;
		end if;
		//Append(~data,[*G,exists_HGS*]);
		if #exists_HGS ge 1 then
			Append(~data,[*G[1],GroupName(G[1]),GroupName(G[2])*]);
		end if;
	end for;
	return data;
end function;