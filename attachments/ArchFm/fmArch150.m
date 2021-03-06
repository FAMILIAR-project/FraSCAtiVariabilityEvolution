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

