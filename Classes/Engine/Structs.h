/*
 *  Structs.h
 *  Santa
 *
 *  Created by Inf on 10.12.09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

/**
 Геометрические координаты вершины в 2D пространстве
 */
typedef struct _VertexCoords {
	short x;
	short y;
	//short z;
}VertexCoords;

/**
 Текстурные координаты вершины
 */
typedef struct _TexCoords {
	float u;
	float v;
}TexCoords;

/**
 Цвет вершины либо объекта
 */
typedef struct _Color {
	/**
	 Красный компонент
	 */
	unsigned char r;
	/**
	 Зеленый компонент
	 */
	unsigned char g;
	/**
	 Синий комонент
	 */
	unsigned char b;
	/**
	 Альфа-компонент
	 */
	unsigned char a;
}Color;

/**
 Полное описание вершины
 */
typedef struct _Vertex {
	/**
	 Геометрические координаты
	 @see _VertexCoords
	 */
	VertexCoords position;
	
	/**
	 Текстурные координаты
	 @see _TexCoords
	 */
	TexCoords texture;
	
	Color color;
}Vertex;
