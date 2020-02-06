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
    ALL_DATA_TABLE_ERROR
}
export class TableDTO {
    columns:Array<ColumnDTO>=new Array();
    indexColumns:Array<IndexColumn>=new Array();
    constructor( 
        public tableName:string
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
