### DPLL Algorithm\
Implementation of the Davis-Putnam-Logemann-Loveland algorithm, a complete search algorithm to decide the satisfiability of a knowledge base, including returning a working model. 

`Literal()` Represents a logicial literal, with name and sign. Example: Literal("A")


`DPPLSatisfiable()` Defines clauses, symbols and an empty model from the KB. Returns whether
or not the KB is satisfiable and if yes one model that satisfies the KB.
The KB is a conjunction of disjunctions of atoms.
Example KB input: {A, B}, {A, -C}, {-A, B, D}]
Example satisfiable output: True
Example model output: {A: true, B: true, C: false, D: free}


`DPLL()` Recursive model that checks satisfiability of a model.
    It first checks whether, given the current model, the KB is
    satisfiable, meaning that all clauses evaluate to True. If that is the case,
    it returns satisfiable=True and model=model for which the KB is satisfiable.
    If it is not satisfiable, it tries different combinations of symbol assign-
    ments recursively:
    1) Pick a symbol
    2) Assign 'true'
    3) Check if clauses are satisfiable
    4) (a) if all clauses are True, return the (satisfiable, model)
       (b) if any clause is False, recurse the tree up and try the same
          symbol with assignment 'false', if that fails too, recurse to the
          previous symbol
       (c) if clauses are undetermined, continue recursion with the next symbol
    As soon as one symbol in the clause is true, the clause is true, since the
    clauses are conjunctions of disjunctions. For (A v B) to be true, either A
    or B can be true.
    However, we need all clauses to be true for the KB to be satisfied. For
    [(A V B) ∧ (C V D)] to be true, (A V B) has to be true and (C V D) has to
    be true.
    

`unit_clause`, `pure_symbol` and `degree_heuristic` are heuristics to improve the choice of symbol and thus enahnce the performance of the algorithm. 


`compare_models` is finally used to show that these heuristics do in fact improve the performance of the algorithm. 
