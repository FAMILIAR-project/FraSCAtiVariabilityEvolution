FraSCAti : ComponentFactory SCAParser AssemblyFactory :: _FraSCAti ;

ComponentFactory : [MembraneFactory] [MembraneGeneration] :: _ComponentFactory ;

MembraneFactory : [OSGiMembrane] [tinfi_ooMembrane] [julia] :: _MembraneFactory ;

MembraneGeneration : [MembraneGenerator] [JavaCompiler] :: _MembraneGeneration ;

MembraneGenerator : [OSGI] [tinfi_oo] :: _MembraneGenerator ;

JavaCompiler : JDT
	| JDK6 ;

SCAParser : Metamodel :: _SCAParser ;

Metamodel : [Tuscany] [MMFraSCAti] SCA :: _Metamodel ;

AssemblyFactory : Binding Interface PropertyType Implementation :: _AssemblyFactory ;

Binding : [http] [rmi] [rest] [ws] [UPnP] [jsonrpc] :: _Binding ;

Interface : [WSDL] [native] :: _Interface ;

PropertyType : [jaxb] :: _PropertyType ;

Implementation : [Spring] [Fractal] [OSGiImplementation] [BPEL] [Script] :: _Implementation ;

OSGiImplementation : Felix
	| Equinox ;

%%

rmi implies MMFraSCAti ;
Fractal implies MMFraSCAti ;
http implies Tuscany ;
rest implies MMFraSCAti ;
Script implies MMFraSCAti ;
jsonrpc implies MMFraSCAti ;
OSGiImplementation implies MMFraSCAti ;

