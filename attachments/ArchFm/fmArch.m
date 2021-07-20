FraSCAti : services component_factory assembly_factory sca_parser binding_factory :: _FraSCAti ;

component_factory : [delegate_membrane_generation] fractal_bootstrap_class_providers* :: _component_factory ;

delegate_membrane_generation : juliac :: _delegate_membrane_generation ;

juliac : [compiler_provider] generators* :: _juliac ;

compiler_provider : jdk6_compiler
	| jdt_compiler ;

generators : tinfi_oo_1
	| osgi ;

fractal_bootstrap_class_providers : julia
	| osgi_provider
	| tinfi_oo ;

assembly_factory : bindings property_types interfaces implementations :: _assembly_factory ;

bindings : [frascati_binding_rest] sca_binding_sca [sca_binding_upnp] [frascati_binding_http] [frascati_binding_jms] [frascati_binding_jna] [frascati_binding_jsonrpc] [frascati_binding_rmi] [sca_binding_ws] :: _bindings ;

property_types : [sca_property_type_jaxb] sca_property_type_java sca_property_type_xsd :: _property_types ;

interfaces : sca_interface_java [sca_interface_wsdl] [sca_interface_native] :: _interfaces ;

implementations : [sca_implementation_bpel] sca_implementation_composite [frascati_implementation_fractal] sca_implementation_java [sca_implementation_spring] [frascati_implementation_osgi] [frascati_implementation_script] :: _implementations ;

sca_parser : metamodels :: _sca_parser ;

metamodels : [sca_metamodel_tuscany] [sca_metamodel_native] [sca_metamodel_upnp] sca_metamodel [sca_metamodel_frascati] :: _metamodels ;

%%

frascati_implementation_osgi implies osgi_provider ;
frascati_binding_jsonrpc implies sca_metamodel_frascati ;
frascati_implementation_script implies sca_metamodel_frascati ;
sca_binding_upnp implies sca_metamodel_upnp ;
sca_interface_native implies sca_metamodel_native ;
sca_metamodel_native implies frascati_binding_jna ;
sca_metamodel_native implies sca_interface_native ;
osgi implies frascati_implementation_osgi ;
sca_interface_native implies frascati_binding_jna ;
tinfi_oo implies juliac ;
delegate_membrane_generation implies juliac ;
frascati_implementation_fractal implies sca_metamodel_frascati ;
sca_implementation_bpel implies sca_interface_wsdl ;
osgi_provider implies osgi ;
frascati_binding_rest implies sca_metamodel_frascati ;
osgi_provider implies frascati_implementation_osgi ;
osgi implies osgi_provider ;
frascati_implementation_osgi implies osgi ;
frascati_binding_rmi implies sca_metamodel_frascati ;
frascati_binding_jna implies sca_metamodel_native ;
sca_metamodel_upnp implies sca_binding_upnp ;
osgi implies sca_metamodel_frascati ;
frascati_binding_jna implies sca_interface_native ;
osgi implies fractal_bootstrap_class_providers ;
frascati_binding_http implies sca_metamodel_tuscany ;

