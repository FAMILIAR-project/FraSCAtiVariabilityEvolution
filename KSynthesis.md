# Reverse Engineering and Maintaining Feature Models

or how '''Breathing Knowledge into Feature Model Synthesis''' can be practically performed for this purpose.

Feature Models (FMs) are a popular formalism for modelling and reasoning about commonality and variability of a concept. The essence of feature models is to define a set of valid combinations of features, also called ''configurations''.
We tackle the problem of constructing a feature model from a set of legal configurations, a process called feature model synthesis.
The main challenge is that numerous candidate feature models can be extracted from the same input configurations, yet only a
few of them are meaningful and maintainable (see examples below). 
We develop a synthesis procedure capable of restituting the intended
meanings of feature models based on user or inferred knowledge. 
The synthesis procedure is supported by the FAMILIAR language. 
We show how the integration of knowledge into feature models synthesis can be realised in different application scenarios such as feature model refactoring, reverse engineering, merging or slicing.
For example, using the language and the synthesis procedure, multiple FMs can be merged while the resulting FM, if not suitable, can be refactored.


[[PageOutline]] 

Contributors (in alphabetical order): 
  * [http://www.i3s.unice.fr/%7Eacher Mathieu Acher (University of Namur, Belgium)]
  * [http://www.fundp.ac.be/universite/personnes/page_view/01005760/ Anthony Cleve (University of Namur, Belgium)]
  * [http://www.info.fundp.ac.be/~phe/ Patrick Heymans (University of Namur, Belgium)]
  * [http://www.fundp.ac.be/universite/personnes/page_view/01000270/ Jean-Luc Hainaut (University of Namur, Belgium)]

## The Feature Model Synthesis Problem

### First example

Given a set of configurations, say ''s0''

```
s0 = 
{
{Anonymized,MI,ModalityAcquisition,CT,Nifti,Format},
{Format,Anonymized,ModalityAcquisition,DICOM,MI,MRI}, 
{MI,Nifti,Format,CT,ModalityAcquisition}
}

```

How to synthesise a feature model that accurately represents ''s0''?

Several feature models are candidates, fm0, fm1, and fm2 (see below)

fm0: [[Image(wiki:KSynthesis:fm0.png, 15%)]] fm1: [[Image(wiki:KSynthesis:fm1.png, 15%)]] fm2: [[Image(wiki:KSynthesis:fm2.png, 15%)]]

Indeed they represent the exact same set of configurations. 
In the ''jargon'' of feature models (see the paper of Thuem, Batory and Kästner, ICSE'09, "Reasoning about Edits to Feature Models"), these feature models are ''refactoring'' in the sense they represent the same set of configurations. 

Below are a FAMILIAR script and an interactive session illustrating this fact:  

```
fm0 = FM (MI : ModalityAcquisition Format  ; 
                    ModalityAcquisition : (MRI|CT) ; 
                    Format : (DICOM|Nifti) [Anonymized] ; 
                    DICOM -> MRI ; 
                    MRI -> Anonymized ; )

fm1 = FM (MI : ModalityAcquisition Format [Anonymized] ; // hum
                    ModalityAcquisition : (DICOM|Nifti) ; // huh
                    Format : (MRI|CT) ;  // huh
                    !CT | !DICOM ; // well...
		    CT | Anonymized ; 
                    )

cmp01 = compare fm0 fm1 // REFACTORING


fm2 = FM (MI : ModalityAcquisition Format [Anonymized] ; 
                    ModalityAcquisition : (MRI|CT) ; 
		    MRI : [DICOM] ; 
                    CT : [Nifti] ; 
		    !DICOM | !Nifti ; DICOM | Nifti ; 
		    MRI -> Anonymized ; 
                    )


addConstraint constraint (Nifti -> CT) to fm0

cmp02 = compare fm0 fm2 // REFACTORING
println "cmp02: ", cmp02

addConstraint constraint (Nifti -> CT) to fm1

cmp12 = compare fm1 fm2 // REFACTORING
println "cmp12: ", cmp12
```

The execution of the script is as follows:

```
$ java -jar -Xmx1024M ~/Documents/FML-0.9.9.4.jar ER12-refactoring.fml
cmp02: REFACTORING

cmp12: REFACTORING

FAMILIAR (for FeAture Model scrIpt Language for manIpulation and Automatic Reasoning)  version 0.9.9.4 (beta)
University of Nice Sophia Antipolis, UMR CNRS 6070, I3S Laboratory
https://nyx.unice.fr/projects/familiar/
fml> configs fm0
res0: (SET) {{Anonymized;MRI;Format;ModalityAcquisition;MI;DICOM};{Nifti;ModalityAcquisition;Format;CT;MI;Anonymized};{CT;Nifti;Format;MI;ModalityAcquisition}}
fml> configs fm1
res1: (SET) {{Anonymized;Format;DICOM;ModalityAcquisition;MI;MRI};{MI;Format;ModalityAcquisition;Nifti;CT};{Nifti;Anonymized;CT;ModalityAcquisition;MI;Format}}
fml> configs fm2
res2: (SET) {{Anonymized;MI;ModalityAcquisition;CT;Nifti;Format};{Format;Anonymized;ModalityAcquisition;DICOM;MI;MRI};{MI;Nifti;Format;CT;ModalityAcquisition}}
fml> compare fm0 fm1
res3: (STRING) REFACTORING
fml> compare fm1 fm2
res4: (STRING) REFACTORING
fml> 
``` 

Note that the ''compare'' operation reasons over the set of configurations (Thuem, Batory and Kästner made a slight difference by considering only leaf features as part of the configurations... It has no impact here)


### Second example 

Let us now consider the set of configurations ''s1''

```
s1 = 
{
{MI,Nifti,CT}, 
{MRI,MI,DICOM}
}
```

typically representing the projected set of configurations of fm0 on features Medical Image, MRI, CT, Nifti, and DICOM

```
> fm0Slice = slice fm0 including { fm0.MI fm0.MRI fm0.CT fm0.Nifti fm0.DICOM } 
> s1 = configs fm0Slice
```

There are still different feature models, including with different feature groups and different constraints:

fm3: [[Image(wiki:KSynthesis:slice1.png, 20%)]] fm4: [[Image(wiki:KSynthesis:slice2.png, 20%)]] fm5: [[Image(wiki:KSynthesis:slice3.png, 20%)]]


Still, they represent the exact same set of configurations '''s1''':

```
$ java -jar -Xmx1024M ~/Documents/FML-0.9.9.4.jar ER12-slices.fml
FAMILIAR (for FeAture Model scrIpt Language for manIpulation and Automatic Reasoning)  version 0.9.9.4 (beta)
University of Nice Sophia Antipolis, UMR CNRS 6070, I3S Laboratory
https://nyx.unice.fr/projects/familiar/
fml> configs fm3
res0: (SET) {{MRI;DICOM;MI};{CT;MI;Nifti}}
fml> configs fm4
res1: (SET) {{MRI;MI;DICOM};{MI;CT;Nifti}}
fml> configs fm5
res2: (SET) {{MI;CT;Nifti};{MRI;MI;DICOM}}
fml> compare fm3 fm4
res3: (STRING) REFACTORING
fml> compare fm4 fm5
res4: (STRING) REFACTORING
fml> 
```

## Concrete syntax 

To overcome this issue, we propose a generic synthesis integrated in the FAMILIAR language. 
It comes through an operator, called ''ksynthesis''.
The operator performs over propositional formulae and computes a feature model. 
Specific directives (see below) can be specified by users for synthesising a feature model with intended properties.  

From a practical perspective, the operator takes as first parameter 
 * either a formula (e.g., specified in the [http://logic.pdmi.ras.ru/~basolver/dimacs.html DIMACS] format, a standard format for boolean formulas in conjunctive normal forms), typically for reverse engineering a feature model ; 
 * or a feature model -- in this case, the corresponding formula of the feature model is considered by the synthesis operator -- typically for refactoring and maintaining an existing feature model


```
fla1 = FM ("fooFla1.dimacs") 
fm1 = FM ("foo1.tvl")
// synthesis (formula)
fm2 = ksynthesis fla1 with hierarchy= A:B G; B : C E O; groups= xorGroup (B: C E) constraints= E implies G
// another synthesis (feature model)
fm1bis = ksynthesis fm1 with hierarchy= A:B C G O; G : E;
```


The directives are all optionals: users can specify either the hierarchy, the way features should be grouped and the constraints expected in the resulting feature model. 
Below is an excerpt of the FAMILIAR Xtext grammar:

```
Synthesis: 'ksynthesis' fm=FMCommand ('with' kst=KnowledgeSpecification)? ;
KnowledgeSpecification : {KnowledgeSpecification} (hierarchy=HierarchySpecification)? 
						 (COMMA groups=GroupsSpecification)? 
						 (COMMA constraints=ConstraintsSpecification)? ;

HierarchySpecification : 'hierarchy=' (features+=HProduction ';')+  ;
HProduction : name=ID ':' features+=FT_ID+ ;

GroupsSpecification : 'groups=' (groups+=GroupSpec ';')+ ;
GroupSpec : XorGroupSpec | MtxGroupSpec | OrGroupSpec ; 
XorGroupSpec : 'xorGroup' LEFT_PAREN name=ID ':' features+=FT_ID+ RIGHT_PAREN ;
MtxGroupSpec : 'mtxGroup' LEFT_PAREN name=ID ':' features+=FT_ID+ RIGHT_PAREN ; 
OrGroupSpec : 'orGroup' LEFT_PAREN name=ID ':' features+=FT_ID+ RIGHT_PAREN ; 

ConstraintsSpecification : 'constraints=' csts+=ConstraintExpr ; 
```

## Applications 

 ### Reverse engineering 

We consider a tabular data describing programs' feature sets (or products descriptions):

[[Image(wiki:KSynthesis:FSTLopez2011.png, 20%)]]

The goal is to produce a feature model whose set of configurations corresponds exactly to programs' feature sets. 
Stated differently, each valid configuration of the feature model should correspond to one program documented in the tabular data. 

The solutions proposed in [http://www.computer.org/portal/web/csdl/doi/10.1109/WCRE.2011.45 Haslinger et al.] and [http://dl.acm.org/citation.cfm?doid=2110147.2110153 Acher et al.] are not completely satisfactory. 
Typically, the feature models produced can exhibit an unstructured hierarchy (see below two examples):

[[Image(wiki:KSynthesis:failLopez1.png, 20%)]]
[[Image(wiki:KSynthesis:failLopez2.png, 20%)]]

The approach proposed in [http://dl.acm.org/citation.cfm?doid=2110147.2110153 Acher et al.] (see also the [https://nyx.unice.fr/projects/familiar/wiki/VariCell dedicated page] of the project) is as follows: each program/product is documented as a feature model and then the feature models are "merged" into an integrated feature model representing the union of set of configurations. 
The major problem is that the procedure cannot determine a hierarchy due to the lack of structure in the tabular data. 
Therefore a flattened hierarchy is chosen by the merging procedure.

```
// from product descriptions to feature models
// typically something generated by VariCell (see VaMoS'12 paper or the dedicated web page)
fm_1 = FM (VOD: R Ae T D P Ad K V O ; )
fm_2 = FM (VOD: R Ae T D P K V O ; )
fm_3 = FM (VOD: Ae T D P Ad K V O ; )
fm_4 = FM (VOD: T Ae D P V K O ; )
fm_5 = FM (VOD: R T Ae D P Ad K V O C ; )
fm_6 = FM (VOD: R T D P Ad V K O C ; )
fm_7 = FM (VOD: R T Ae D P V K O C ; )
fm_8 = FM (VOD: R T D P K V O C ; )
fm_9 = FM (VOD: Ae T D P Ad V K O C ; )
fm_10 = FM (VOD: T D P Ad K V O C ; )
fm_11 = FM (VOD: Ae T D P V K O C ; )
fm_12 = FM (VOD: T D P K V O C ; )
fm_13 = FM (VOD: R S D P Ad V K O M ; )
fm_14 = FM (VOD: R S D P K V O M ; )
fm_15 = FM (VOD: S D P Ad V K O M ; )
fm_16 = FM (VOD: S D P V K O M ; )

// fmR represents the union of configurations/products
// characterized by fm_1, fm_2, ..., fm_16
fmR = merge sunion fm_*

// unfortunately the "merge" is likely to produce unsatisfacory feature models
// mainly because the hierarchy is flattened
// note also that many feature groups are conflicting
```

 ### Refactoring 

The key idea is to use the synthesis procedure and the '''ksynthesis''' operator to ''breath'' knowledge when producing the feature model.

```
// refactoring!
fmR2 = ksynthesis fmR with hierarchy=VOD : V P R D O ; O : K Ad ; D : T M ; T : Ae C ; M : S ;

// by simply specifying the intended hierarchy, the synthesis procedure produces
// an accurate feature model (actually the one expected)
```

[[Image(wiki:KSynthesis:groundTruthFMLopez2011.png, 20%)]]
