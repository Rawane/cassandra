import {CollectionViewer, DataSource} from "@angular/cdk/collections";
import {BehaviorSubject,Observable,of} from 'rxjs';
import { catchError, finalize } from 'rxjs/operators';
import {GaindeService} from '../services/gainde.service';
import {Pagination} from '../model/model-dto';


export class GaindeDataSource implements DataSource<JSON> {
    private dataRowsSubject = new BehaviorSubject<JSON[]>([]);
    private loadingSubject = new BehaviorSubject<boolean>(false);
    public loading = this.loadingSubject.asObservable();
    columns:string[];
    columnsDisplayed:string[];
    columnsQuery:string[];
    currentPagination:Pagination;
    mapPageState=new Map<number,Pagination>();
    isQuery:boolean=false;
    mapWhereClause=new Map<string,string>();
    whereColumnValue:string;
    whereColumnName:string;
    constructor(private gaindeService: GaindeService) {
        this.currentPagination=new Pagination();
        this.currentPagination.pageSate='';
        this.currentPagination.pageNumSate=1;       
        this.currentPagination.total=-1;
        this.currentPagination.pageNum=1;        
    }
    connect(collectionViewer: CollectionViewer): Observable<JSON[]> {
        return this.dataRowsSubject.asObservable();
    }

    disconnect(collectionViewer: CollectionViewer): void {
        this.dataRowsSubject.complete();  
        this.loadingSubject.complete();     
    }
    loadDataRows(tableName: string, filter = '',
            sortDirection = 'asc',total=-1,pageSate='',pageNumSate=1, pageSize = 20, pageIndex = 1) {
      console.log('loadDataRows'+JSON.stringify(this.currentPagination));  
      console.log('loadDataRows pagesate '+pageIndex+"  "+pageNumSate+"  "+this.currentPagination.pageNum);       
      console.log('11 loadDataRows pageSate '+pageSate); 
    this.loadingSubject.next(true);
    let connecTionName=this.gaindeService.currentGainde.connectionName;
    let keyspaceName=this.gaindeService.currentGainde.keyspaceName;
    if(this.currentPagination.pageNum>pageIndex){
        console.log('loadDataRows precedent '+this.currentPagination.pageNum+"  "+pageIndex); 
        let paginate=this.mapPageState.get(pageIndex);
        if(paginate){
            pageSate=paginate.pageSate;
            pageNumSate=paginate.pageNumSate;
            console.log('loadDataRows pageSate '+pageSate); 
        }else{
            let keys = Array.from(this.mapPageState.keys() );
            keys.sort((a, b) => a-b);
            if(keys.length>0){
                paginate=this.mapPageState.get(keys[keys.length-1]); 
                pageSate=paginate.pageSate;
                pageNumSate=paginate.pageNumSate;  
            }
            console.log('loadDataRows keys '+JSON.stringify(keys)); 
        }
    }
    this.gaindeService.getAllDataPaginate(connecTionName, keyspaceName,tableName,total,pageSate,pageNumSate,pageSize,pageIndex,this.isQuery,this.mapWhereClause
        ).pipe(
        catchError(() => of([])),
        finalize(() => {console.log("loadDataRows fini");
        this.loadingSubject.next(false);})
    )
    .subscribe(results => {
        this.columns=results['columns'];
        this.columnsDisplayed=[];
        this.columnsQuery=[];
        if(results['columns']){
            results['columns'].forEach((column:any) => {                
                this.columnsDisplayed.push(column['name']);
                if(column['partitionKey']||column['clusteredColumn'] || column['indexed']){
                   this.columnsQuery.push(column['name']);
                }
            });
            this.columnsDisplayed.push('action_gainde');
            this.columnsDisplayed.push('action_remove_gainde');
        }
        console.log('loadDataRows columns '+JSON.stringify(this.columns));
        if(results['pagination']){   
            this.mapPageState.set(this.currentPagination.pageNumSate,this.currentPagination);        
            this.currentPagination=new Pagination();
            this.currentPagination.pageSate=results['pagination']['pageSate'];
            this.currentPagination.pageNumSate=results['pagination']['pageNumSate'];
            this.currentPagination.pageSize=results['pagination']['pageSize'];
            this.currentPagination.pageNum=results['pagination']['pageNum'];
            this.currentPagination.total=results['pagination']['total'];
           
        }
        if(results['data']){
            this.dataRowsSubject.next(results['data']);
        }
    });
    }    
}