export class KeyspaceDTO {
    constructor( public name: string,public strategy:string,public replication:string,public durableWrite:boolean
       ){

    }
   
}