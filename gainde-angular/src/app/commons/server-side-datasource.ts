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
    currentPagination:Pagination;
    constructor(private gaindeService: GaindeService) {}
    connect(collectionViewer: CollectionViewer): Observable<JSON[]> {
        return this.dataRowsSubject.asObservable();
    }

    disconnect(collectionViewer: CollectionViewer): void {
        this.dataRowsSubject.complete();  
        this.loadingSubject.complete();     
    }
    loadDataRows(tableName: string, filter = '',
            sortDirection = 'asc',total=-1,pageSate='',pageNumSate=1, pageSize = 20, pageIndex = 1) {
    this.loadingSubject.next(true);
    let connecTionName=this.gaindeService.currentGainde.connectionName;
    let keyspaceName=this.gaindeService.currentGainde.keyspaceName;
    this.gaindeService.getAllDataPaginate(connecTionName, keyspaceName,tableName,total,pageSate,pageNumSate,pageSize,pageIndex
        ).pipe(
        catchError(() => of([])),
        finalize(() => {console.log("loadDataRows fini");
        this.loadingSubject.next(false);})
    )
    .subscribe(results => {
        this.columns=[];
        results['columns'].forEach((column:any) => {
            this.columns.push(column['name']);
        });
        console.log('loadDataRows columns '+JSON.stringify(this.columns));
        if(results['pagination']){
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