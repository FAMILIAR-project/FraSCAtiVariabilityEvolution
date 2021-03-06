FraSCAti : FraSCAtiModules FraSCAtiArchitecture :: _FraSCAti ;

FraSCAtiModules : [_frascati_implementation_osgi_felix] [_frascati_implementation_script] [_frascati_binding_jsonrpc] [_frascati_metamodel_frascati] [_frascati_component_factory_juliac_jdt] [_frascati_binding_http] [_frascati_property_jaxb] [_frascati_sca_compiler_parent] [_frascati_util_xml] [_frascati_metamodel_frascati_ext] [_module_upnp] [_frascati_implementation_fractal] [_frascati_component_factory_juliac_tinfi_oo] [_frascati_implementation_spring] [_frascati_binding_jms] [_frascati_util] [_module_native] [_frascati_component_factory_tinfi_oo] [_frascati_implementation_osgi_equinox] [_frascati_implementation_osgi] [_frascati_all] [_frascati_tinfi_sca_parser] [_frascati_assembly_factory_jdk6] [_frascati_assembly_factory_juliac_jdt_tinfi_oo] [_frascati_binding_jms_tests] [_frascati_binding_rest] [_frascati_interface_wsdl] [_frascati_servlet_cxf] [_frascati_binding_ws] [_frascati_implementation_bpel] _frascati_sca_parser _frascati_component_factory [_frascati_binding_rmi] [_frascati_all_jdk6] _frascati_assembly_factory [_frascati_binding_factory] [_frascati_component_factory_juliac_jdk6] [_frascati_metamodel_tuscany] [_frascati_component_factory_juliac] [_frascati_component_factory_julia] :: _FraSCAtiModules ;

FraSCAtiArchitecture : services component_factory assembly_factory sca_parser binding_factory :: _FraSCAtiArchitecture ;

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

assembly_factory : bindings* property_types* interfaces* implementations* :: _assembly_factory ;

bindings : frascati_binding_rest
	| sca_binding_sca
	| sca_binding_upnp
	| frascati_binding_http
	| frascati_binding_jms
	| frascati_binding_jna
	| frascati_binding_jsonrpc
	| frascati_binding_rmi
	| sca_binding_ws ;

property_types : sca_property_type_jaxb
	| sca_property_type_java
	| sca_property_type_xsd ;

interfaces : sca_interface_java
	| sca_interface_wsdl
	| sca_interface_native ;

implementations : sca_implementation_bpel
	| sca_implementation_composite
	| frascati_implementation_fractal
	| sca_implementation_java
	| sca_implementation_spring
	| frascati_implementation_osgi
	| frascati_implementation_script ;

sca_parser : metamodels* :: _sca_parser ;

metamodels : sca_metamodel_tuscany
	| sca_metamodel_native
	| sca_metamodel
	| sca_metamodel_upnp
	| sca_metamodel_frascati ;

%%

frascati_implementation_osgi implies _frascati_implementation_osgi ;
_frascati_metamodel_frascati implies sca_metamodel_frascati ;
_frascati_binding_rmi implies frascati_binding_rmi ;
osgi implies _frascati_implementation_osgi ;
_frascati_implementation_osgi implies osgi ;
_frascati_all implies _frascati_metamodel_tuscany ;
_frascati_servlet_cxf implies _frascati_assembly_factory ;
_frascati_binding_ws implies _frascati_binding_factory ;
_frascati_assembly_factory_juliac_jdt_tinfi_oo implies _frascati_component_factory_juliac_tinfi_oo ;
_module_native implies sca_metamodel_native ;
_module_upnp implies sca_metamodel_upnp ;
_frascati_implementation_script implies _frascati_metamodel_frascati ;
_frascati_component_factory_juliac_jdt implies jdt_compiler ;
jdk6_compiler implies _frascati_component_factory_juliac_jdk6 ;
_frascati_assembly_factory_juliac_jdt_tinfi_oo implies _frascati_component_factory_juliac_jdt ;
_frascati_implementation_script implies _frascati_assembly_factory ;
frascati_binding_http implies _frascati_binding_http ;
_frascati_binding_factory implies binding_factory ;
_frascati_binding_ws implies sca_binding_ws ;
_frascati_binding_ws implies _frascati_assembly_factory ;
_frascati_sca_parser implies _frascati_util ;
_frascati_tinfi_sca_parser implies _frascati_sca_parser ;
_frascati_assembly_factory_jdk6 implies _frascati_assembly_factory ;
_frascati_all implies _frascati_implementation_fractal ;
_frascati_all implies _frascati_servlet_cxf ;
_frascati_component_factory_juliac_tinfi_oo implies _frascati_component_factory_juliac ;
julia implies _frascati_component_factory_julia ;
_frascati_assembly_factory implies sca_implementation_java ;
_frascati_implementation_spring implies sca_implementation_spring ;
_frascati_all implies _frascati_binding_jms ;
sca_metamodel_native implies _module_native ;
sca_metamodel_frascati implies _frascati_metamodel_frascati ;
juliac implies _frascati_component_factory_juliac ;
jdt_compiler implies _frascati_component_factory_juliac_jdt ;
sca_interface_native implies _module_native ;
assembly_factory implies _frascati_assembly_factory ;
_frascati_component_factory_tinfi_oo implies _frascati_component_factory ;
_frascati_implementation_bpel implies sca_implementation_bpel ;
_frascati_all implies _frascati_implementation_bpel ;
_frascati_assembly_factory implies sca_implementation_composite ;
binding_factory implies _frascati_binding_factory ;
_frascati_binding_jsonrpc implies frascati_binding_jsonrpc ;
frascati_binding_rmi implies _frascati_binding_rmi ;
_frascati_property_jaxb implies sca_property_type_jaxb ;
sca_metamodel_upnp implies _module_upnp ;
_frascati_assembly_factory implies _frascati_component_factory_tinfi_oo ;
sca_metamodel_tuscany implies _frascati_metamodel_tuscany ;
_frascati_binding_rmi implies _frascati_assembly_factory ;
frascati_binding_rest implies _frascati_binding_rest ;
_frascati_all implies _frascati_sca_parser ;
_frascati_interface_wsdl implies _frascati_assembly_factory ;
_frascati_binding_rest implies _frascati_binding_factory ;
_frascati_component_factory_juliac_jdt implies _frascati_component_factory_juliac ;
_frascati_implementation_fractal implies frascati_implementation_fractal ;
_frascati_assembly_factory implies sca_interface_java ;
component_factory implies _frascati_assembly_factory ;
_frascati_binding_http implies frascati_binding_http ;
frascati_binding_jms implies _frascati_binding_jms ;
_frascati_all implies _frascati_component_factory_juliac_jdt ;
sca_implementation_spring implies _frascati_implementation_spring ;
_frascati_assembly_factory implies sca_property_type_java ;
sca_binding_upnp implies _module_upnp ;
_frascati_all implies _frascati_binding_factory ;
osgi_provider implies _frascati_implementation_osgi ;
_frascati_implementation_osgi implies frascati_implementation_osgi ;
_frascati_metamodel_tuscany implies sca_metamodel_tuscany ;
_frascati_all implies _frascati_implementation_script ;
_frascati_component_factory_juliac implies juliac ;
_frascati_binding_jsonrpc implies _frascati_assembly_factory ;
_frascati_all_jdk6 implies _frascati_assembly_factory_jdk6 ;
_frascati_component_factory_julia implies julia ;
_frascati_assembly_factory implies sca_binding_sca ;
_frascati_component_factory_juliac_jdk6 implies _frascati_component_factory_juliac ;
_frascati_assembly_factory implies _frascati_sca_parser ;
_frascati_all implies _frascati_property_jaxb ;
sca_implementation_composite implies _frascati_assembly_factory ;
_frascati_assembly_factory implies services ;
_frascati_binding_jms implies _frascati_binding_factory ;
_frascati_component_factory implies _frascati_util ;
tinfi_oo implies _frascati_component_factory_juliac_tinfi_oo ;
_frascati_implementation_bpel implies _frascati_interface_wsdl ;
sca_binding_ws implies _frascati_binding_ws ;
_frascati_component_factory_julia implies _frascati_assembly_factory ;
_frascati_metamodel_tuscany implies _frascati_assembly_factory ;
_frascati_all implies _frascati_metamodel_frascati ;
frascati_binding_jna implies _module_native ;
_frascati_binding_rmi implies _frascati_metamodel_frascati ;
sca_binding_sca implies _frascati_assembly_factory ;
_frascati_implementation_osgi_felix implies _frascati_implementation_osgi ;
_frascati_implementation_fractal implies _frascati_metamodel_frascati ;
_frascati_util_xml implies _frascati_util ;
_frascati_implementation_fractal implies _frascati_assembly_factory ;
_frascati_assembly_factory implies assembly_factory ;
_frascati_all implies _frascati_assembly_factory ;
_frascati_all implies _frascati_binding_ws ;
_frascati_assembly_factory implies sca_property_type_xsd ;
sca_property_type_java implies _frascati_assembly_factory ;
_frascati_implementation_spring implies _frascati_assembly_factory ;
_frascati_binding_http implies _frascati_metamodel_tuscany ;
_frascati_binding_jsonrpc implies _frascati_binding_factory ;
_frascati_all implies _frascati_interface_wsdl ;
sca_metamodel implies _frascati_sca_parser ;
frascati_implementation_fractal implies _frascati_implementation_fractal ;
_frascati_assembly_factory_juliac_jdt_tinfi_oo implies _frascati_assembly_factory ;
_module_native implies frascati_binding_jna ;
_frascati_implementation_osgi implies _frascati_assembly_factory ;
_frascati_binding_http implies _frascati_assembly_factory ;
_frascati_binding_rest implies _frascati_assembly_factory ;
_frascati_implementation_bpel implies _frascati_util_xml ;
_frascati_component_factory_juliac_jdk6 implies jdk6_compiler ;
_frascati_assembly_factory implies component_factory ;
_frascati_component_factory_juliac_tinfi_oo implies tinfi_oo ;
_frascati_all implies _frascati_implementation_spring ;
_frascati_binding_rest implies _frascati_metamodel_frascati ;
_frascati_interface_wsdl implies sca_interface_wsdl ;
_module_upnp implies sca_binding_upnp ;
sca_property_type_jaxb implies _frascati_property_jaxb ;
_frascati_all implies _frascati_binding_rest ;
frascati_binding_jsonrpc implies _frascati_binding_jsonrpc ;
sca_property_type_xsd implies _frascati_assembly_factory ;
_frascati_metamodel_frascati implies _frascati_assembly_factory ;
_frascati_sca_parser implies sca_metamodel ;
_frascati_binding_rest implies frascati_binding_rest ;
_frascati_all implies _frascati_component_factory_juliac_tinfi_oo ;
_frascati_binding_jms_tests implies _frascati_binding_jms ;
_module_native implies sca_interface_native ;
_frascati_binding_jms implies frascati_binding_jms ;
_frascati_assembly_factory_jdk6 implies _frascati_component_factory_juliac_tinfi_oo ;
_frascati_implementation_script implies frascati_implementation_script ;
_frascati_binding_jms implies _frascati_assembly_factory ;
sca_implementation_bpel implies _frascati_implementation_bpel ;
_frascati_binding_jms implies _frascati_util_xml ;
_frascati_all implies _frascati_binding_http ;
_frascati_all implies _frascati_binding_rmi ;
_frascati_all implies _frascati_component_factory_julia ;
_frascati_all implies _frascati_component_factory_juliac ;
_frascati_assembly_factory_jdk6 implies _frascati_component_factory_juliac_jdk6 ;
_frascati_implementation_osgi implies _frascati_metamodel_frascati ;
sca_implementation_java implies _frascati_assembly_factory ;
sca_interface_java implies _frascati_assembly_factory ;
_frascati_component_factory_julia implies _frascati_component_factory ;
_frascati_all implies _frascati_binding_jsonrpc ;
_frascati_all implies _frascati_implementation_osgi ;
_frascati_implementation_osgi_equinox implies _frascati_implementation_osgi ;
_frascati_binding_rmi implies _frascati_binding_factory ;
_frascati_binding_jsonrpc implies _frascati_metamodel_frascati ;
_frascati_implementation_osgi implies osgi_provider ;
sca_parser implies _frascati_sca_parser ;
_frascati_all implies _frascati_component_factory_tinfi_oo ;
_frascati_implementation_bpel implies _frascati_assembly_factory ;
_frascati_binding_jms_tests implies _frascati_interface_wsdl ;
_frascati_property_jaxb implies _frascati_assembly_factory ;
_frascati_all implies _frascati_component_factory ;
services implies _frascati_assembly_factory ;
_frascati_sca_parser implies sca_parser ;
sca_interface_wsdl implies _frascati_interface_wsdl ;
_frascati_all implies _frascati_implementation_osgi_equinox ;
_frascati_component_factory_juliac implies _frascati_component_factory ;
frascati_implementation_script implies _frascati_implementation_script ;

