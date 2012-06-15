/*
 *  NetworkProtocol.h
 *  MathWars
 *
 *  Created by Inf on 11.03.10.
 *  Copyright 2010 Soulteam. All rights reserved.
 *
 */

#ifndef MW_NETWORK_PROTOCOL
#define MW_NETWORK_PROTOCOL

#define MAX_MAP_OBJECTS 32

typedef enum _MWNetworkMessageType {
	MWNetworkMessageSendMap,
	MWNetworkMessageUnitMoved,
	MWNetworkMessageBuildingStarted,
	MWNetworkMessageUpgradeStarted,
	MWNetworkMessagePuzzleSolved,
	MWNetworkMessagePuzzleFailed,
	MWNetworkMessageTurnEnded,
	MWNetworkMessageSurrender,
	MWNetworkMessageReadyToNextCombatRound
}MWNetworkMessageType;

typedef enum _MWMapObjectType {
	MWMapObjectBase,
	MWMapObjectFactory,
	MWMapObjectBarricades,
	MWMapObjectMineField,
	MWMapObjectSwamp,
	MWMapObjectGorge,
	MWMapObjectCoalWarehouse,
	MWMapObjectWeaponary,
	MWMapObjectRepairer,
	MWMapObjectSheild,
}MWMapObjectType;

typedef struct _MWNetworkMapObject {
	MWMapObjectType type;
	uint8_t owner;
	Float32 x;
	Float32 y;
}MWNetworkMapObject;

typedef struct _MWNetworkMap {
	int32_t objectCount;
	MWNetworkMapObject objects[MAX_MAP_OBJECTS];
	BOOL roadsGraph[MAX_MAP_OBJECTS][MAX_MAP_OBJECTS];
	
}MWNetWorkMapParams;

typedef struct _MWNetworkMoveUnit {
	uint16_t unitId;
	uint8_t targetId;
}MWNetworkMoveUnit;

typedef struct _MwNetworkBuild {
	uint8_t factoryId;
	uint8_t unitType;
}MWnetworkBuild;

typedef struct _MWNetworkUpgrade {
	uint8_t factoryId;
}MWNetworkUpgrade;

#endif
