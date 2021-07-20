= Join the Dots with VariCell = 

The use of feature models to describe the common and variable features of a family of products is becoming commonplace. Unfortunately, the task of creating a feature model from an existing source is both time-consuming and error-prone, requiring substantial effort from the designer. We developed a semi-automated process as well as tool support for extracting feature models based on product descriptions, tabular data for instance. The tool support is composed of a dedicated language, called VariCell, for parameterizing through high-level directives (e.g., products/features scoping) the extraction process. We guarantee that the resulting feature model represents the valid combination of features supported by products and has a readable tree hierarchy together with variability information, including feature groups and constraints.

Contributors (in alphabetical order): 
  * [http://www.i3s.unice.fr/%7Eacher Mathieu Acher (University of Namur, Belgium)]
  * Anthony Cleve (University of Namur, Belgium)
  * [http://www.i3s.unice.fr/%7Ecollet Philippe Collet (University of Nice Sophia Antipolis, France)] 
  * Patrick Heymans (University of Namur, Belgium)
  * [http://www.i3s.unice.fr/%7Elahire Philippe Lahire (University of Nice Sophia Antipolis, France)]
  * Gilles Perrouin (University of Namur, Belgium)
  * Charles Vanbeneden (University of Namur, Belgium)
  

= Short Tutorial = 

== Overview: From Product Descriptions to a Feature Model ==

Let us consider the domain of Wiki engines. The list of features supported/offered by a set of Wiki engines can be documented using a semi-structured specification (e.g., tabular data). 
We use an excerpt of data from [http://www.wikimatrix.org Wikimatrix], which provides information about different wiki engines. 
The tabular data can be specified, for instance, using comma-separated values (CSV) or an XML format. The example below corresponds to [attachment:paperExampleTable.csv this CSV file].
Each row of the table documents a product, i.e., a Wiki engine, and the list of features it supports. For example, the Confluence wiki has a Commercial license that costs 10 USD and it supports RSS feeds, whereas the MoinMoin wiki has a GPL licence; DokuWiki, PmWiki, DrupalWiki and MediaWiki engines are all written in PHP, etc.

[[Image(wiki:VariCell:WikiEngines.png, 35%)]]


Based on such ''product descriptions'', a practitioner might consider that the eight Wiki engines form a family of products and might want to build a model that represents the commonalities and variabilities of those eight products. We rely on ''feature models'', a popular formalism for modeling and reasoning about variability. It can be used, for instance, to pilot configuration of a set of products.

[[Image(wiki:VariCell:FD-ExampleNoRedundancy.png, 45%)]]

The variability of a family of products is modeled in terms of mandatory, optional and exclusive features as well as Boolean constraints over the features. Feature models characterize the scope of a family of products by specifying the set of combination of features (configurations) supported or not.

For example, {WikiSPL, License, GPL, Language, Python, Storage, Files, RSS, Unicode } is a valid configuration of the feature model shown above. 
The intuition is that for each valid configuration of a feature model corresponds to at least one product of the family. In the tabular data described above, 8 products are documented but the corresponding feature model represents 7 valid configurations. The reason is that products DokuWiki and PmWiki actually correspond to the same configuration {WikiSPL, License, GPL2, Language, PHP, Storage, Files, RSS, Unicode }. 

We can observe that the feature diagram (i.e., hierarchy + feature groups + biimplies/implies/excludes constraints) represents only 11 configurations and over approximates the expected set of configurations. For example, the configuration {WikiMatrix, License, GPL, Language, PHP, Storage, Files, RSS, Unicode } is valid w.r.t. the feature diagram but its does not correspond to any product. The reason is that the use of biimplies, implies and excludes constraints is not expressively sufficient, thus justifying the presence of additional propositional constraints, not depicted here (see ψ cst).

== VariCell ==

In their current form, semi-structured (e.g., tabular) data are not semantically rich enough to directly translate as a feature model. A key issue is the transformation of data in terms of feature hierarchy and variability.
We propose a domain-specific language (DSL), called ''VariCell'', so that practitioners can specify high-level directives and parameterize the data transformation.

The language provides some facilities for:

 * '''Parsing''': A practitioner can import several sources of data (i.e., CSV files) that are then associated to a view. Some parsing instructions, specific to the CSV format, can be specified including the definition of the separator or multivalued separator. The parsing instructions can be specified for all views or for a specific view ; Products/entities are identified by keys (which can be composite keys) and the practitioner can define, for example, which column of the CSV file the keys correspond to. We assume that the same key is used to identify a product in the different data sources. Therefore a key can be specified only in the default part and cannot be redefined in a view.
 * '''Scoping''': A practitioner may scope the data in various ways and for many purposes. For instance, not all products have to be integrated in the family of products since some products are considered as too poor in terms of supported features or not competitive enough. An- other example is that not all features have to be considered, for example, the version number of the product may not be a relevant information. The language directives except products and only products are specified to (not) consider products for all imported views. Note that the DSL directives except features and only features can be specified within a specific view.
 * '''Transforming Data''': It includes renaming or rewriting facilities or more complex mapping. Importantly, the interpretation of data in terms of variability (e.g., to define when a feature is considered to be optional) can be specified either for all data sources and views or for a specific view.
 * '''Specifying Structure''': Views are possibly related to each other (e.g., to describe a sub-domain) and this structuring information is usually not explicit in the format. By default, the feature model of a view is inserted be- low the root feature. A practitioner may want to impose a specific hierarchy. For example, hosting below general means that the feature model of the hosting view is inserted below the feature model of the general view. This information has an impact on the hierarchy of the resulting feature model and is used by the extraction procedure.

=== Realization ===

The execution of a VariCell specification should produce a feature model representing the combinations of features actually supported by the products set.
To realize the overall process, we rely on [https://nyx.unice.fr/projects/familiar/ FAMILIAR]. More precisely, the interpreter of VariCell generates FAMILIAR instructions for building feature models of a product, for aggregating feature models or for merging feature models. See, for instance, the [attachment:WikiMatrix.fml FAMILIAR script generated for the example given above]. The FAMILIAR instructions are finally executed to synthesize a feature model. 

=== Additional Example === 

Let us consider the following product descriptions (see also the corresponding [attachment:hartmann2009.csv CSV file]). 

[[Image(wiki:VariCell:HartmannTableCSV.png, 60%)]]

The products are provided by three suppliers A, B and C. 
It should be noted that the products of supplier A, B or C exhibit some variability (some features are optional, value "Opt" in the cell).
The [attachment:hartmann2009.varicell VariCell script] is used to interpret cell values in terms of variability. 
The [attachment:SuppliersHartmann.fml generated FAMILIAR instructions] can be downloaded as well as the [attachment:SuppliersHartmann.fmlbdd synthesized feature model] (the feature diagram is serialized as well as the BDD-based representation of the propositional formula). 

=== Preliminary Experiments (data corpus, VariCell scripts, FAMILIAR generation, synthesized feature model) ===

 * WM0: example described above [attachment:paperExample.varicell VariCell script] [attachment:WikiMatrix.fml FML script generated] [attachment:WikiMatrix.fmlbdd synthesized feature model]
 * H: reference Hartmann et al. that describes an excerpt of a suppliers' offering, documenting variability of the products in a table [attachment:hartmann2009.varicell VariCell script] [attachment:SuppliersHartmann.fml FML script generated] [attachment:SuppliersHartmann.fmlbdd synthesized feature model]
 * L: catalog of products (laptops) stored in CSV files and available from SPLOT [attachment:DELL-LAPTOP.varicell VariCell script] [attachment:LaptopDELL.fml FML script generated] [attachment:LaptopDELL.fmlbdd synthesized feature model]
 * B: catalog of products (bikes) stored in CSV files and available from SPLOT ; we make vary the features included (see VariCell scripts)
  * B1: [attachment:TREK_BIKES.varicell VariCell script] [attachment:BikesTrek.fml FML script generated] [attachment:BikesTrek.fmlbdd synthesized feature model]
  * B2: [attachment:TREK_BIKES1.varicell VariCell script] [attachment:BikesTrek.2.fml FML script generated] [attachment:BikesTrek.2.fmlbdd synthesized feature model]
  * B3: [attachment:TREK_BIKES2.varicell VariCell script] [attachment:BikesTrek.3.fml FML script generated] [attachment:BikesTrek.3.fmlbdd synthesized feature model]
 * C: a comparative table, including variability information, provided by an external person [attachment:PaaS_Comparison.varicell VariCell script] [attachment:PaaSFD.fml FML script generated] [attachment:PaaSFD.fmlbdd synthesized feature model]
 * WM: Wikimatrix website that provides access to information of a large set of wiki engines. 154 wiki engines are documented. Each wiki engine describes several characteristics classified in 16 categories (General, Media and Files, Usability, etc.). We convert the XML file located in http://www.wikimatrix.org/api/byproduct into 16 CSV different files (one file per category).
  * WM1 [attachment:test_NP=20_NV=2_NFT=7.varicell VariCell script] [attachment:WikiMatrix.2.fml FML script generated] [attachment:WikiMatrix.2.fmlbdd synthesized feature model]
  * WM2 [attachment:test_NP=30_NV=2_NFT=7.varicell VariCell script] [attachment:WikiMatrix.3.fml FML script generated] [attachment:WikiMatrix.3.fmlbdd synthesized feature model]
  * WM3 [attachment:test_NP=20_NV=3_NFT=4.varicell VariCell script] [attachment:WikiMatrix.4.fml FML script generated] [attachment:WikiMatrix.4.fmlbdd synthesized feature model]
