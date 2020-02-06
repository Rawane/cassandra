export class ConnectionDTO {
    constructor( public name: string,public ip:string,public port:number,public username:string,
        public password:string
       ){

    }
   
}
export class KeyspaceDTO {    
    constructor( public name: string,public strategy:string,
        public replication:string,public durableWrite:boolean,
        public dataCenter:string
       ){

    }
   
}
export class GaindeItem {
    constructor( public connectionName: string,public keyspaceName:string,
        public tableName:string,public counter:number
       ){

    }
   
}
export enum ActionHttp{
    ALL_CONNECTION,
    ALL_CONNECTION_ERROR,
    CLOSE_CONNECTION,
    CLOSE_CONNECTION_ERROR,
    CONNECT_TO,
    CONNECT_TO_ERROR,
    INFO_TABLE,
    INFO_TABLE_ERROR,
    SAVE_CONNECTION,
    SAVE_CONNECTION_ERROR,
    UPDATE_CONNECTION,
    UPDATE_CONNECTION_ERROR,
    DELETE_CONNECTION,
    DELETE_CONNECTION_ERROR,
    ALL_META,
    ALL_META_ERROR,
    INFO_KEYSPACE,
    INFO_KEYSPACE_ERROR,
    SAVE_KEYSPACE,
    SAVE_KEYSPACE_ERROR,
    REMOVE_KEYSPACE,
    REMOVE_KEYSPACE_ERROR,
    REMOVE_TABLE,
    REMOVE_TABLE_ERROR,
    ALL_DATA_TABLE,
    ALL_DATA_TABLE_ERROR,
    ADD_TABLE,
    ADD_TABLE_ERROR
}
export class TableDTO {
    columns:Array<ColumnDTO>=new Array();
    indexColumns:Array<IndexColumn>=new Array();
    constructor( 
        public name:string
       ){

    }
   
}
export class ColumnDTO {
    name:string ;
     type:string ;   
	 typeList:string ; 
	 typeMap:string;  
	 primaraKey:boolean=false;  
	 indexed:boolean=false;
    constructor(        
       ){
    }   
}
export class IndexColumn {
     name:string ;   
	 columName:string ;	
    constructor(         
       ){
    }   
}

export const TypeColonnes = [
    {name:'ASCII',value:1}, 
    {name:'TEXT',value:10},
    {name:'BIGINT',value:2},
    {name:'BLOB',value:3},
    {name:'BOOLEAN',value:4},
    {name:'COUNTER',value:5},
    {name:'DECIMAL',value:6},
    {name:'DOUBLE',value:7},
    {name:'FLOAT',value:8},
    {name:'INT',value:9},
    {name:'TIMESTAMP',value:11},
    {name:'UUID',value:12},
    {name:'VARCHAR',value:13},
    {name:'VARINT',value:14},
    {name:'TIMEUUID',value:15},
    {name:'INET',value:16},
    {name:'DATE',value:17},
    {name:'TIME',value:18},
    {name:'SMALLINT',value:19},
    {name:'TINYINT',value:20},
    {name:'DURATION',value:21}
];
export const TypeColonnesCollect = [
    {name:'LIST',value:32},
    {name:'SET',value:33},
    {name:'MAP',value:34}

];
export const TypeColonnesAll=TypeColonnes.concat(TypeColonnesCollect);