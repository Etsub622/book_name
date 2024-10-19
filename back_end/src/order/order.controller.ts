import { Body, Controller, Post } from '@nestjs/common';
import { OrderService } from './order.service';

@Controller('order')
export class OrderController {
    constructor(private readonly orderService: OrderService) {}
   

    @Post()
    async createOrder(@Body('bookId') bookId:string){
        return this.orderService.createOrder(bookId);
        
    }
}
