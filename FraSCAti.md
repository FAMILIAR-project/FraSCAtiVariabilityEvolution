# Extraction and Evolution of Architectural Variability Models in Plugin-based Systems 

note: the content was originally written in 2012... we edited some parts

The following web page provides material, details and results of the experiments we conduct in reverse engineering architectural feature models from different versions of the [FraSCAti project](http://frascati.ow2.org).

preprint: https://hal.inria.fr/hal-00859472 

'''Contributors'''

 * [Mathieu Acher](http://www.mathieuacher.com/)
 * [Anthony Cleve](http://www.fundp.ac.be/universite/personnes/page_view/01005760/) 
 * [Philippe Collet](http://www.i3s.unice.fr/~collet) 
 * [Philippe Merle](http://www.lifl.fr/~merle)
 * [Laurence Duchien](http://www.lifl.fr/~duchien/Laurence/index.html)
 * [Philippe Lahire](http://www.i3s.unice.fr/~lahire) 




## Case Study and Motivation 

### FraSCAti Architecture 

Started three years ago, the development of the FraSCAti platform begun with a framework, first validated by a basic implementation of the standard, and then incrementally enhanced.
After four major releases, it now supports several SCA specifications (Assembly Model, Transaction Policy, Java Common Annotations and APIs, Java Component Implementation, Spring Component Implementation, BPEL Client and Implementation, Web Services Binding, JMS Binding), and provides a set of extensions to the standard, 
including binding implementation types (HTTP, Java RMI, JMS, JSON-RPC, REST, SOAP, JNA, UPnP), component implementation types (composite, Java, BPEL, Fractal, OSGi, Scala, Java supported scripting languages like !BeanShell, Groovy, !JavaScript, Jython, JRuby), interface description types (Java, WSDL, UPnP, C headers), property description types (Java et XSD), runtime API for assembly and component introspection/reconfiguration (see paper at [http://hal.inria.fr/inria-00397856 SCC'09]).

As its capabilities grew, FraSCAti has also been refactored and completely architected itself with SCA components.
With all these capabilities, the platform has become highly (re-)configurable in many parts of its own architecture.
It notably exposes a larger number of extensions that can be activated throughout the platform, creating numerous variants of a FraSCAti deployment.
For example, some variations consist in one or more specific components bound to many other mandatory or optional parts of the platform architecture.
It then became obvious to FraSCAti technical leads that the variability (i.e., "the ability of a software system or artefact to be efficiently extended, changed, customized or configured for use in a particular context.") of the platform should be managed to pilot and control its evolution as a ''Software Product Line (SPL)''.


### FraSCAti Artefacts 

The entire set of .composite files and SCA diagrams form the "architectural model" of FraSCAti.

.composite_diagram and .png files have been automatically generated using Eclipse SCA Tools (plus a manual layout). 

You can download the .composite and .composite_diagram files below. Note that the files are from the last version of the FraSCAti project. 


#### main SCA composite of FraSCAti (other components are described below) 
<img src="attachments/ArchFm/org.ow2.frascati.FraSCAti.png" />

#### implementations, interfaces, bindings and properties 
![](attachments/ArchFm/org.ow2.frascati.assembly.factory.AssemblyFactory.png) <!-- .element height="50%" width="50%" -->

#### SCA composite of the FraSCAti parser 
<img src="attachments/ArchFm/org.ow2.frascati.parser.Parser.png" width="50%" />

#### SCA composite of the FraSCAti composite parser
<img src="attachments/ArchFm/org.ow2.frascati.parser.CompositeParser.png" width="40%" />

#### metamodels supported by the FraSCAti SCA parser
<img src="attachments/ArchFm/org.ow2.frascati.parser.ScaParser.png" />

#### membranes 
<img src="attachments/ArchFm/org.ow2.frascati.component.factory.ComponentFactory.png" />

#### Java compilers and membrane generators 
<img src="attachments/ArchFm/org.ow2.frascati.component.factory.juliac.Juliac.png" /> 

#### binding factory
<img src="attachments/ArchFm/org.ow2.frascati.binding.factory.BindingFactory.png" />

#### services (empty composite at the moment) 
<img src="attachments/ArchFm/org.ow2.frascati.Services.png" width="10%" />



### Goal: Extraction and Evolution of FraSCAti Architectural Variability Model 

In order to manage the FraSCAti platform as an SPL, we needed to capture its variability from the existing architecture.
We chose to rely on a particular kind of variability model, ''Feature Models (FMs)'', based on their wide adoption, the existence of formal semantics, reasoning techniques and tool support.  
Several software artefacts (SCA composite files, Maven descriptors, unformal documents) describe FraSCAti architecture, but variability, though, is not explicitly represented.
As the FraSCAti main ''software architect (SA)'' had an extensive expertise in the architecture and in its evolution, it was decided to make him model the architecture he has in mind with variation points (see left part of the figure). As a domain expert, he had the ability to elicitate the architectural variation points and explain rationale behind these decisions.

<img src="attachments/ArchFm/motivation.png" />

This task resulted in a manually created FM (see Figure, or  download the FM ([attachment:fmMerle.m FeatureIDE] or [attachment:fmMerle.fmprimitives S2T2] format)) and it was clearly daunting, time-consuming and error-prone, requiring substantial effort from the SA.

<img src="attachments/ArchFm/fmMerle.png" />

In this case as in all large scale architectures, it is very difficult to guarantee that the resulting FM ensures a safe composition of the architectural elements when some features are selected.
Another approach thus relies on an automated extraction, so that an architectural FM that represents variability of the architecture is automatically extracted from the appropriate artefacts (see right part of the figure). This operation clearly saves time and reduces accidental complexity, but the accuracy of the results directly depends on the quality of the available documents and of the extraction procedure.

## Extraction of Architectural Variability Model 

#### Overview and illustration

We now describe how we realize the ''extraction procedure''. 

<img src="attachments/ArchFm/extracting.png" />

Let us a take a simple example, summarized by the following figure: 

<img src="attachments/ArchFm/projectionExample3.png" />

where FMs are examplified versions of FMArch150, FMPlugin, FMArch.

The set of configurations is as follows:

<img src="attachments/ArchFm/sFMArch150.png" />
<img src="attachments/ArchFm/sFMFull.png" />
<img src="attachments/ArchFm/sFMArch.png" />


Using the language FAMILIAR (the file [attachment:projectionExample.fml] is available for download), we can realize the scenario ...

 
<img src="attachments/ArchFm/projectionExampleFML.png" />


... and give information to the software architect (e.g., which configurations have been removed from the 150% architectural FM).

[[Image(wiki:ArchFm:projectionExampleEclipseConsole.png, 20%)]]

A similar FAMILIAR script has been used for computing the enforced architectural FM of FraSCAti (see below). 

### FAMILIAR code 

To produce the enforced architectural FM, we use the following FAMILIAR code: 

<img src="attachments/ArchFm/projectionExampleEclipseConsole.png" />

### Visualisation of feature models 

 #### 150% architectural feature model 

The following figure is a visual representation of a so called "150% architectural FM" (you can also download the FM ([https://nyx.unice.fr/projects/familiar/attachment/wiki/ArchFm/fmArch150.m FeatureIDE] or [attachment:fm150.fmprimitives S2T2] format)), using [http://download.lero.ie/spl/s2t2/ S2T2].

[[Image(wiki:ArchFm:fm150.png, 20%)]]

 #### plugins feature model 

The following figure is a visual representation of a so called "plugins FM" (you can also download the FM ([attachment:fmPlugin.m FeatureIDE] or [attachment:fmPlugin.fmprimitives S2T2] format)), using [http://download.lero.ie/spl/s2t2/ S2T2].

[[Image(wiki:ArchFm:fmPlugin.png, 15%)]]

 #### FMFull, an aggregation of the two FMs with constraints 

The following figure is a visual representation of a "FMFull" (you can also download the FM ([attachment:fmFull.m FeatureIDE] or [attachment:fmFull.fmprimitives S2T2] format)), using [http://download.lero.ie/spl/s2t2/ S2T2].

<img src="attachments/ArchFm/fmFull.png" />

#### enforced architectural feature model 

The following figure is a visual representation of the enforced architectural FM (you can also download the FM ([attachment:fmArch.m FeatureIDE] or [attachment:fmArch.fmprimitives S2T2] format)), using [http://download.lero.ie/spl/s2t2/ S2T2].

<img src="attachments/ArchFm/fmArch.png" />



## Properties of the feature models 





{{{
#!html
The case study FraSCAti is a typical example in which the problem of feature model evolution occurs and needs to be properly tackled. You can have a look at the presentation made at <a href="http://www.ecsa2011.org/" target="_blank">ECSA'11</a> conference or <a href="http://soft.vub.ac.be/benevol2011/index.html" target="_blank">BENEVOL'11</a> workshop:
<div style="width:425px" id="__ss_10535798"> <strong style="display:block;margin:12px 0 4px"> <a href="http://www.slideshare.net/acher/benevol11-reverse-engineering-architectural-feature-models" title="BENEVOL&#39;11 - Reverse Engineering Architectural Feature Models" target="_blank"> Reverse Engineering Architectural Feature Models</a></strong> <iframe src="http://www.slideshare.net/slideshow/embed_code/10535798" width="425" height="355" frameborder="0" marginwidth="0" marginheight="0" scrolling="no"></iframe></div>
}}}

The challenge for a practitioner (e.g., software architect) is, for example, to understand and validate the evolutions between two versions of FraSCAti w.r.t. variability.

<img src="attachments/DiffFMs/Full14.png" />
<img src="attachments/DiffFMs/Full15.png" />

As a result, we used extensively the differencing techniques as well as the FAMILIAR language/environment to support those activities. 


### Feature Models 
 
  * version 1.3: see above the links
  * version 1.4 (you can download the feature model in [attachment:Full14.fml FML] or [attachment:Full14.m FeatureIDE]) or 
  * version 1.5 (you can download the feature model in [attachment:Full15.fml FML] or [attachment:Full15.m FeatureIDE])
