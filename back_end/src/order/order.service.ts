import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Order } from './schema/order.schema';
import { Model } from 'mongoose';
import { BookService } from 'src/book/book.service';
import axios from 'axios';
import { nanoid } from 'nanoid';


@Injectable()
export class OrderService {
    constructor(
        @InjectModel(Order.name) private orderModel:Model<Order>,
        private readonly bookService: BookService,
    ){}


    async createOrder(bookId:string):Promise<any>{
        const book = await this.bookService.getBookById(bookId);

        if(!book){
            throw new Error('Book not found');
        }

     
        const txRef = nanoid();
        const order = await this.orderModel.create({
            bookId:bookId,
            txRef:txRef,
            bookPrice:book.price,
            bookName:book.title,
         
        });


        const chapaRequestData = {
            amount:book.price,
            currency:'ETB',
            tx_ref:txRef,
            
        };

        const response = await axios.post(
            'https://api.chapa.co/v1/transaction/mobile-initialize',
            chapaRequestData,
            {headers:{
                Authorization:`Bearer ${process.env.CHAPA_SECRET_KEY}`,  
                'Content-Type':'application/json',
            }}
        );

        return {
            msg:'Order created successfully',
            paymentUrl : response.data.data.checkout_url,
            Order:order,
        };
    }
}
