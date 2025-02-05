/decl/hierarchy/supply_pack/engineering
	name = "Engineering"

/decl/hierarchy/supply_pack/engineering/lightbulbs
	name = "Replacement lights"
	contains = list(/obj/item/storage/box/lights/mixed = 5)
	cost = 10
	containertype = /obj/structure/closet/crate/engineering
	containername = "\improper Replacement lights"

/decl/hierarchy/supply_pack/engineering/smes_circuit
	name = "Superconducting Magnetic Energy Storage Unit Circuitry"
	contains = list(/obj/item/circuitboard/smes)
	cost = 20
	containertype = /obj/structure/closet/crate/engineering
	containername = "\improper Superconducting Magnetic Energy Storage Unit Circuitry"

/decl/hierarchy/supply_pack/engineering/smescoil
	name = "Superconductive Magnetic Coil"
	contains = list(/obj/item/smes_coil)
	cost = 35
	containertype = /obj/structure/closet/crate/engineering
	containername = "\improper Superconductive Magnetic Coil crate"

/decl/hierarchy/supply_pack/engineering/smescoil_weak
	name = "Basic Superconductive Magnetic Coil"
	contains = list(/obj/item/smes_coil/weak)
	cost = 25
	containertype = /obj/structure/closet/crate/engineering
	containername = "\improper Basic Superconductive Magnetic Coil crate"

/decl/hierarchy/supply_pack/engineering/smescoil_super_capacity
	name = "Superconductive Capacitance Coil"
	contains = list(/obj/item/smes_coil/super_capacity)
	cost = 45
	containertype = /obj/structure/closet/crate/engineering
	containername = "\improper Superconductive Capacitance Coil crate"

/decl/hierarchy/supply_pack/engineering/smescoil_super_io
	name = "Superconductive Transmission Coil"
	contains = list(/obj/item/smes_coil/super_io)
	cost = 45
	containertype = /obj/structure/closet/crate/engineering
	containername = "\improper Superconductive Transmission Coil crate"

/decl/hierarchy/supply_pack/engineering/electrical
	name = "Electrical maintenance crate"
	contains = list(/obj/item/storage/toolbox/electrical = 2,
					/obj/item/clothing/gloves/insulated = 2,
					/obj/item/cell = 2,
					/obj/item/cell/high = 2)
	cost = 15
	containertype = /obj/structure/closet/crate/engineering
	containername = "\improper Electrical maintenance crate"

/decl/hierarchy/supply_pack/engineering/mechanical
	name = "Mechanical maintenance crate"
	contains = list(/obj/item/storage/belt/utility/full = 3,
					/obj/item/clothing/suit/storage/hazardvest = 3,
					/obj/item/clothing/head/welding = 2,
					/obj/item/clothing/head/hardhat)
	cost = 10
	containertype = /obj/structure/closet/crate/engineering
	containername = "\improper Mechanical maintenance crate"

/decl/hierarchy/supply_pack/engineering/solar
	name = "Solar Pack crate"
	contains  = list(/obj/item/solar_assembly = 14,
					/obj/item/circuitboard/solar_control,
					/obj/item/tracker_electronics,
					/obj/item/paper/solar
					)
	cost = 15
	containertype = /obj/structure/closet/crate/engineering
	containername = "\improper Solar Pack crate"

/decl/hierarchy/supply_pack/engineering/solar_assembly
	name = "Solar Assembly crate"
	contains  = list(/obj/item/solar_assembly = 16)
	cost = 10
	containertype = /obj/structure/closet/crate/engineering
	containername = "\improper Solar Assembly crate"

/decl/hierarchy/supply_pack/engineering/emitter
	name = "Emitter crate"
	contains = list(/obj/machinery/power/emitter = 2)
	cost = 10
	containertype = /obj/structure/closet/crate/secure/large
	containername = "\improper Emitter crate"
	access = access_engine_equip

/decl/hierarchy/supply_pack/engineering/field_gen
	name = "Field Generator crate"
	contains = list(/obj/machinery/field_generator = 2)
	containertype = /obj/structure/closet/crate/large
	cost = 10
	containername = "\improper Field Generator crate"
	access = access_ce

/decl/hierarchy/supply_pack/engineering/sing_gen
	name = "Singularity Generator crate"
	contains = list(/obj/machinery/the_singularitygen)
	cost = 10
	containertype = /obj/structure/closet/crate/secure/large
	containername = "\improper Singularity Generator crate"
	access = access_ce

/decl/hierarchy/supply_pack/engineering/collector
	name = "Collector crate"
	contains = list(/obj/machinery/power/rad_collector = 2)
	cost = 6
	containertype = /obj/structure/closet/crate/secure/large
	containername = "\improper Collector crate"
	access = access_engine_equip

/decl/hierarchy/supply_pack/engineering/PA
	name = "Particle Accelerator crate"
	contains = list(/obj/structure/particle_accelerator/fuel_chamber,
					/obj/machinery/particle_accelerator/control_box,
					/obj/structure/particle_accelerator/particle_emitter/center,
					/obj/structure/particle_accelerator/particle_emitter/left,
					/obj/structure/particle_accelerator/particle_emitter/right,
					/obj/structure/particle_accelerator/power_box,
					/obj/structure/particle_accelerator/end_cap)
	cost = 40
	containertype = /obj/structure/largecrate
	containername = "\improper Particle Accelerator crate"
	access = access_ce

/decl/hierarchy/supply_pack/engineering/pacman_parts
	name = "P.A.C.M.A.N. portable generator parts"
	contains = list(/obj/item/stock_parts/micro_laser,
					/obj/item/stock_parts/capacitor,
					/obj/item/stock_parts/matter_bin,
					/obj/item/circuitboard/pacman)
	cost = 45
	containertype = /obj/structure/closet/crate/secure/engineering
	containername = "\improper P.A.C.M.A.N. Portable Generator Construction Kit"
	access = access_tech_storage

/decl/hierarchy/supply_pack/engineering/super_pacman_parts
	name = "Super P.A.C.M.A.N. portable generator parts"
	contains = list(/obj/item/stock_parts/micro_laser,
					/obj/item/stock_parts/capacitor,
					/obj/item/stock_parts/matter_bin,
					/obj/item/circuitboard/pacman/super)
	cost = 55
	containertype = /obj/structure/closet/crate/secure/engineering
	containername = "\improper Super P.A.C.M.A.N. portable generator construction kit"
	access = access_tech_storage

/decl/hierarchy/supply_pack/engineering/teg
	name = "Mark I Thermoelectric Generator"
	contains = list(/obj/machinery/power/generator)
	cost = 75
	containertype = /obj/structure/closet/crate/secure/large
	containername = "\improper Mk1 TEG crate"
	access = access_engine_equip

/decl/hierarchy/supply_pack/engineering/circulator
	name = "Binary atmospheric circulator"
	contains = list(/obj/machinery/atmospherics/binary/circulator)
	cost = 60
	containertype = /obj/structure/closet/crate/secure/large
	containername = "\improper Atmospheric circulator crate"
	access = access_atmospherics

/decl/hierarchy/supply_pack/engineering/air_dispenser
	name = "Pipe Dispenser"
	contains = list(/obj/machinery/pipedispenser/orderable)
	cost = 35
	containertype = /obj/structure/closet/crate/secure/large
	containername = "\improper Pipe Dispenser Crate"
	access = access_atmospherics

/decl/hierarchy/supply_pack/engineering/disposals_dispenser
	name = "Disposals Pipe Dispenser"
	contains = list(/obj/machinery/pipedispenser/disposal/orderable)
	cost = 35
	containertype = /obj/structure/closet/crate/secure/large
	containername = "\improper Disposal Dispenser Crate"
	access = access_atmospherics

/decl/hierarchy/supply_pack/engineering/shield_generator
	name = "Shield Generator Construction Kit"
	contains = list(/obj/item/circuitboard/shield_generator, /obj/item/stock_parts/capacitor, /obj/item/stock_parts/micro_laser, /obj/item/smes_coil, /obj/item/stock_parts/console_screen)
	cost = 50
	containertype = /obj/structure/closet/crate/secure/engineering
	containername = "\improper shield generator construction kit crate"
	access = access_engine

/decl/hierarchy/supply_pack/engineering/smbig
	name = "Supermatter Core"
	contains = list(/obj/machinery/power/supermatter)
	cost = 200
	containertype = /obj/structure/closet/crate/secure/large/plasma
	containername = "\improper Supermatter crate (CAUTION)"
	access = access_ce

/decl/hierarchy/supply_pack/engineering/fueltank
	name = "Fuel tank crate"
	contains = list(/obj/structure/reagent_dispensers/fueltank)
	cost = 8
	containertype = /obj/structure/largecrate
	containername = "\improper fuel tank crate"

/decl/hierarchy/supply_pack/engineering/robotics
	name = "Robotics assembly crate"
	contains = list(/obj/item/device/assembly/prox_sensor = 3,
					/obj/item/storage/toolbox/electrical,
					/obj/item/device/flash = 4,
					/obj/item/cell/high = 2)
	cost = 10
	containertype = /obj/structure/closet/crate/secure/gear
	containername = "\improper Robotics assembly"
	access = access_robotics

/decl/hierarchy/supply_pack/engineering/radsuit
	name = "Radiation protection gear"
	contains = list(/obj/item/clothing/suit/radiation = 6,
			/obj/item/clothing/head/radiation = 6)
	cost = 20
	containertype = /obj/structure/closet/radiation
	containername = "\improper Radiation suit locker"

/decl/hierarchy/supply_pack/engineering/painters
	name = "Painting Supplies"
	contains = list(/obj/item/device/pipe_painter = 2,
					/obj/item/device/floor_painter = 2,
					/obj/item/device/cable_painter = 2)
	cost = 10
	containertype = /obj/structure/closet/crate/engineering
	containername = "\improper painting supplies crate"

/decl/hierarchy/supply_pack/engineering/bluespacerelay
	name = "Emergency Bluespace Relay Assembly Kit"
	contains = list(/obj/item/circuitboard/bluespacerelay,
					/obj/item/stock_parts/manipulator,
					/obj/item/stock_parts/manipulator,
					/obj/item/stock_parts/subspace/filter,
					/obj/item/stock_parts/subspace/crystal,
					/obj/item/storage/toolbox/electrical)
	cost = 75
	containertype = /obj/structure/closet/crate/engineering
	containername = "\improper emergency bluespace relay assembly kit"

/decl/hierarchy/supply_pack/engineering/firefighter
	name = "Firefighting equipment"
	contains = list(/obj/item/clothing/suit/fire/firefighter,
			/obj/item/clothing/mask/gas,
			/obj/item/tank/oxygen/red,
			/obj/item/extinguisher,
			/obj/item/clothing/head/hardhat/red)
	cost = 20
	containertype = /obj/structure/closet/firecloset
	containername = "\improper fire-safety closet"

/decl/hierarchy/supply_pack/engineering/voidsuit
	name = "Engineering voidsuit"
	contains = list(/obj/item/clothing/suit/space/void/engineering/alt,
					/obj/item/clothing/head/helmet/space/void/engineering/alt,
					/obj/item/clothing/shoes/magboots)
	cost = 60
	containername = "\improper Engineering voidsuit crate"
	containertype = /obj/structure/closet/crate/secure/large
	access = access_engine

/decl/hierarchy/supply_pack/engineering/rig
	name = "EVA RIG"
	contains = list(/obj/item/rig/eva/equipped)
	cost = 240
	containername = "\improper EVA RIG crate"
	containertype = /obj/structure/closet/crate/secure/engineering
	access = access_engine_equip
