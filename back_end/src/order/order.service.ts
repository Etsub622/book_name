import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Order } from './schema/order.schema';
import { Model } from 'mongoose';
import { BookService } from 'src/book/book.service';
import axios from 'axios';

@Injectable()
export class OrderService {
    constructor(
        @InjectModel(Order.name) private orderModel: Model<Order>,
        private readonly bookService: BookService,
    ){}

    async createOrder(bookId: string) {
        const book = await this.bookService.getBookById(bookId);
        if (!book) {
            throw new Error('Book not found');
        }

        const { nanoid } = await import('nanoid');
        const orderId = nanoid();

        const order = new this.orderModel({
            book: bookId,
            orderId,
        });

        return order.save();
    }
}